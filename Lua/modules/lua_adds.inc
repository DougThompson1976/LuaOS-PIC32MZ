/*
 * Whitecat, adds to lua.c
 *
 * Copyright (C) 2015 - 2016
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.org)
 * 
 * All rights reserved.  
 *
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both that the copyright notice and this
 * permission notice and warranty disclaimer appear in supporting
 * documentation, and that the name of the author not be used in
 * advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * The author disclaim all warranties with regard to this
 * software, including all implied warranties of merchantability
 * and fitness.  In no event shall the author be liable for any
 * special, indirect or consequential damages or any damages
 * whatsoever resulting from loss of use, data or profits, whether
 * in an action of contract, negligence or other tortious action,
 * arising out of or in connection with the use or performance of
 * this software.
 */

#include "pthread.h"

volatile lua_State *gLuaState;

pthread_mutex_t lua_mutex;

static int dofile (lua_State *L, const char *name);

extern int threadInited;

static void whitecat_init(lua_State *L) {
    int  boot;
    FILE *fp;
    int i;
    
    char *boot_order[] = {
        "autorun.lua",
        "autorun.lc",
        "/sd/autorun.lua",
        "/sd/autorun.lc",
    };

    printf("\n");
    
    // Execute system.lua, if exists
    if (fp = fopen("system.lua", "r" )) {
        fclose(fp);

        printf("Executing system.lua ...\n");
        dofile(L, "system.lua");
    }  

    // Ecexute boot script
    boot = -1;
    for(i = 0; i < sizeof(boot_order) / sizeof(*boot_order); i++) {
        if (fp = fopen(boot_order[i], "r" )) {
            fclose(fp);
            boot = i;
            break;
        }
    }
        
    if (boot >=0) {
        printf("Executing %s ...\n", boot_order[i]);
        dofile(L, boot_order[i]);
    }
    
    printf("\n");
}

inline void LuaLockInit(lua_State *L) {
    if (threadInited) {
        pthread_mutexattr_t attr;

        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

        pthread_mutex_init(&lua_mutex, &attr);
    }
}

inline void LuaLock(lua_State *L) {
    if (threadInited) {
        pthread_mutex_lock(&lua_mutex);
    }
}

inline void LuaUnlock(lua_State *L) {
    if (threadInited) {
        pthread_mutex_unlock(&lua_mutex);
    }
}