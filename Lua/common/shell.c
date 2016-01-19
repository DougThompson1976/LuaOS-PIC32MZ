#include "whitecat.h"

#include "lua.h"
#include "lauxlib.h"

#include <stdlib.h>
#include <string.h>
#include <stddef.h>

#if USE_SHELL

const char delimiters[] = " \r\n";

static void *do_ls(char *line) {
    char *directory;
    
    directory = strtok(NULL, delimiters);
    if (!directory) {
        sprintf(line,"os.ls()", directory);    
    } else {
        sprintf(line,"os.ls(\"%s\")", directory);        
    }
}

static void *do_cd(char *line) {
    char *directory;
    
    directory = strtok(NULL, delimiters);
    if (!directory) {
        sprintf(line,"os.cd()", directory);    
    } else {
        sprintf(line,"os.cd(\"%s\")", directory);        
    }
}

static void *do_clear(char *line) {
    sprintf(line,"os.clear()");    
}

static void *do_edit(char *line) {
    char *path;
    
    path = strtok(NULL, delimiters);
    if (!path) {
        sprintf(line,"os.edit()", path);    
    } else {
        sprintf(line,"os.edit(\"%s\")", path);        
    }
}

static void *do_cat(char *line) {
    char *path;
    
    path = strtok(NULL, delimiters);
    if (!path) {
        sprintf(line,"os.cat()", path);    
    } else {
        sprintf(line,"os.cat(\"%s\")", path);        
    }
}

static void *do_more(char *line) {
    char *path;
    
    path = strtok(NULL, delimiters);
    if (!path) {
        sprintf(line,"os.more()", path);    
    } else {
        sprintf(line,"os.more(\"%s\")", path);        
    }
}

static void *do_dmesg(char *line) {
    char *path;
    
    path = strtok(NULL, delimiters);
    if (!path) {
        sprintf(line,"os.dmesg()", path);    
    } else {
        sprintf(line,"os.dmesg(\"%s\")", path);        
    }
}

static void *do_exit(char *line) {
    sprintf(line,"os.exit()");    
}

int lua_shell(char *line) {
    char cline[LUA_MAXINPUT];
    char *token;
 
    strcpy(cline, line);

    token = strtok(cline, delimiters);
    if (token) {
        if (strcmp(token,"ls") == 0) {
            do_ls(line); return 1;
        } else if (strcmp(token,"cd") == 0) {
            do_cd(line); return 1;      
        } else if (strcmp(token,"clear") == 0) {
            do_clear(line); return 1;   
        } else if (strcmp(token,"edit") == 0) {
            do_edit(line); return 1;      
        } else if (strcmp(token,"cat") == 0) {
            do_cat(line); return 1;      
        } else if (strcmp(token,"more") == 0) {
            do_more(line); return 1;      
        } else if (strcmp(token,"dmesg") == 0) {
            do_dmesg(line); return 1;      
        } else if (strcmp(token,"exit") == 0) {
            do_exit(line); return 1;      
        }
    }
    
    return 0;
}

#endif