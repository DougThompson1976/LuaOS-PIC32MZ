#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h> 
#include <param.h>
#include <stdio.h>

#include <drivers/console/console.h>
#include <sys/syscalls/mount.h>
#include <sys/syscalls/device.h>

static int os_cp(lua_State *L) {
    const char *src = luaL_optstring(L, 1, NULL);
    const char *dst = luaL_optstring(L, 2, NULL);
    FILE *fsrc, *fdst;
    char c;
    int res1, res2;
    
    fsrc = fopen(src,"r");
    if (!fsrc) {
        return luaL_fileresult(L, 0, src);
    }

    fdst = fopen(dst,"w");
    if (!fdst) {
        fclose(fsrc);
        return luaL_fileresult(L, 0, dst);
    }
    
    c = fgetc(fsrc);
    while (!feof(fsrc)) {
        fputc(c, fdst);
        c = fgetc(fsrc);    
    }
    
    res1 = fclose(fsrc);
    res2 = fclose(fdst);
    
    if (res1 != 0) {
        return luaL_fileresult(L, 0, src);
    }

    if (res2 != 0) {
        return luaL_fileresult(L, 0, dst);
    }
    
    lua_pushboolean(L, 1);
    return 1;
}

static int os_ls (lua_State *L) {
    const char *path = luaL_optstring(L, 1, NULL);
    DIR *dir = NULL;
    struct dirent *ent;
    char type;
    char size[9];
    char cpath[MAXPATHLEN];
    
    // If path is not present get the current directory as path
    if (!path) {
        if (!getcwd(cpath, (size_t)sizeof(cpath))) {
            return luaL_fileresult(L, 0, cpath);
        }    
        
        path = cpath;
    }
    
    // Open directory
    dir = opendir(path);
    if (!dir) {
        return luaL_fileresult(L, 0, path);
    }

    // Read entries
    while ((ent = readdir(dir)) != NULL) {
        type = 'd';
        if (ent->d_type == DT_REG) {
            type = 'f';
            sprintf(size,"%8d", ent->d_reclen);
        } else if (ent->d_type == DT_LNK) {
            type = 'l';
            sprintf(size,"%8d", ent->d_reclen);
        } else {
            strcpy(size, "       -");
        }
        
        printf("%c\t%s\t%s\n",
            type,
            size,
            ent->d_name
        );
    }
    
    closedir(dir);

    return 0;    
}

static int os_cd (lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
      
    if (chdir(path) < 0) {
        return luaL_fileresult(L, 0, path);
    }

    return 0;
}

static int os_pwd (lua_State *L) {
    char path[MAXPATHLEN];
    
    if (getcwd(path, (size_t)sizeof(path))) {
        lua_pushstring(L, path);
        return 1;
    } else {
        return luaL_fileresult(L, 0, path);
    }
}

static int os_mkdir (lua_State *L) {
    const char *path = luaL_optstring(L, 1, NULL);
    DIR *dir = NULL;
    struct dirent *ent;
    char type;
    char size[9];
    char cpath[MAXPATHLEN];
    
    // If path is not present get the current directory as path
    if (!path) {
        if (!getcwd(cpath, (size_t)sizeof(cpath))) {
            return luaL_fileresult(L, 0, cpath);
        }    
        
        path = cpath;
    }
    
    return luaL_fileresult(L, mkdir(path, 0) == 0, path);
}

static int os_edit (lua_State *L) {
    const char *path = luaL_checkstring(L, 1);

    // Create file if does not exists
    FILE *fp = fopen(path, "a");
    if (!fp) {
        luaL_fileresult(L, 0, path);
    }
    fclose(fp);
  
    char* lua_argv[] = {(char *)"edit", (char *)path, NULL};
    edit_main(2, lua_argv);
    console_clear();
    return 0;    
}

static int os_clear (lua_State *L) {
    console_clear();
    
    return 0;
}

static int more(const char *path, int stop) {
    FILE *fp;
    int rows = 0;
    int cols = 0;
    char c;
    char ch;
    int lines;

    fp = fopen(path,"r");
    if (!fp) {
        return -1;
    }

    if (stop) {
        console_clear();
        console_size(&rows, &cols);

        rows--;
        lines = 0;
    }

    while((c = fgetc(fp)) != EOF) {
        if ((c == '\n') && (stop)) {
            lines++;
            if (lines == rows) {
                console_statusline(path,": any key for next page, q for exit");
                ch = getchar();
                if ((ch == 'q') || (ch == 'Q')) {
                    console_clearstatusline();
                    break;
                }

                lines = 0;
                console_clear();
            }
        }

        printf("%c",c);
    }

    fclose(fp);
}

static int os_cat(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    int res;
    
    if ((res = more(path, 0)) < 0) {
        luaL_fileresult(L, 0, path);
    }

    return 0;
}

static int os_more(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    int res;
    
    if ((res = more(path, 1)) < 0) {
        luaL_fileresult(L, 0, path);
    }

    return 0;
}

static int os_dmesg(lua_State *L) {
    char path[30];
    int res;    
    char *fname;
    
    fname = mount_secondary_or_primary("/log/messages.log");

    if ((res = more(fname, 1)) < 0) {
        luaL_fileresult(L, 0, path);
    }

    free(fname);

    return 0;
}

static int os_format(lua_State *L) {
    const char *device = luaL_checkstring(L, 1);
    char response = ' ';
    struct devops *ops;
    
    if (strcmp(device,"cfi") != 0) {
         return luaL_error(L, "device %s not yet supported for format", device);                    
    }
    
    // Check for mounted device
    if (!mount_is_mounted(device)) {
         return luaL_error(L, "device %s is not mounted", device);            
    }
    
    // Confirmation
    while ((response != 'y') && (response != 'Y') && (response != 'n') && (response != 'N')) {
        printf("\r");
        console_erase_l();
        printf("All data in %s will be deleted. Continue? [y/n]: ", device);
        response = getc(stdin);
    }
    
    printf("\n");
    
    if ((response == 'y') || (response == 'Y')) {
        ops = getdevops(device);
        (*ops->fo_format)();  
    } else {
        printf("Format cancelled\n");
    }
    
    return 0;
}

static int os_sleep(lua_State *L) {   
    cpu_sleep();
}
