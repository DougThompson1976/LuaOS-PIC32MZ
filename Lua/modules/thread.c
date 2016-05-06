/*
 * Whitecat, pthread wrapper for whitecat
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

#include <stdlib.h>
#include <assert.h>
#include <signal.h>
#include <errno.h>

#include "lua.h"
#include "lapi.h"
#include "lauxlib.h"
#include "lgc.h"
#include "lmem.h"
#include "ldo.h"

#include "pthread.h"

#define LTHREAD_STATUS_RUNNING   1
#define LTHREAD_STATUS_SUSPENDED 2

int threadInited = 0; // Module threadInited?

struct lthread {
    lua_State *PL; // Parent thread
    lua_State *L;  // Thread state
    int function_ref;
    int thread_ref;
    int status;
    int thid;
    pthread_t thread;
};

// List of threads
static struct list lthread_list;

static void init() {
    if (!threadInited) {
        list_init(&lthread_list, 1);
        
        threadInited = 1;
    }
}

void thread_terminated(void *args) {
    struct lthread *thread;
    
    int *thid = (void *)args;
    int res = list_get(&lthread_list, *thid, &thread);
    if (!res) {    
        luaL_unref(thread->PL, LUA_REGISTRYINDEX, thread->function_ref);
        luaL_unref(thread->PL, LUA_REGISTRYINDEX, thread->thread_ref);
            
        list_remove(&lthread_list, *thid);
    }
}

void *thread_start_task(void *arg) {
    struct lthread *thread;
    int *thid;
    thread = (struct lthread *)arg;
    
    luaL_checktype(thread->L, 1, LUA_TFUNCTION);
    
    thid = malloc(sizeof(int));
    *thid = thread->thid;
    pthread_cleanup_push(thread_terminated, thid);

    lua_pcall(thread->L, 0, 0, 0);

    return NULL;
}

static int thread_suspend_pthreads(lua_State *L, int thid) {
    struct lthread *thread;
    int res, idx;
    
    if (thid) {
        idx = thid;
    } else {
        idx = list_first(&lthread_list);
    }
    
    while (idx >= 0) {
        res = list_get(&lthread_list, idx, &thread);
        if (res) {
            return luaL_error(L, "can't suspend thread %d", idx);
        }

        // If thread is created, suspend
        if (thread->thread) {
            _pthread_suspend(thread->thread);

            // Update thread status
            thread->status = LTHREAD_STATUS_SUSPENDED;
        }

        if (!thid) {
            idx = list_next(&lthread_list, idx);
        } else {
            idx = -1;
        }
    }  
    
    return 0;
}

static int thread_resume_pthreads(lua_State *L, int thid) {
    struct lthread *thread;
    int res, idx;
    
    if (thid) {
        idx = thid;
    } else {
        idx = list_first(&lthread_list);
    }
    
    while (idx >= 0) {
        res = list_get(&lthread_list, idx, &thread);
        if (res) {
            return luaL_error(L, "can't resume thread %d", idx);
        }

        // If thread is created, suspend
        if (thread->thread) {
            _pthread_resume(thread->thread);

            // Update thread status
            thread->status = LTHREAD_STATUS_RUNNING;
        }

        if (!thid) {
            idx = list_next(&lthread_list, idx);
        } else {
            idx = -1;
        }
    }  
    
    return 0;
}

static int thread_stop_pthreads(lua_State *L, int thid) {
    struct lthread *thread;
    int res, idx;
    
    if (thid) {
        idx = thid;
    } else {
        idx = list_first(&lthread_list);
    }
    
    while (idx >= 0) {
        res = list_get(&lthread_list, idx, &thread);
        if (res) {
            return luaL_error(L, "can't stop thread %d", idx);
        }

        // If thread is created, suspend
        if (thread->thread) {
            _pthread_stop(thread->thread);            
            _pthread_free(thread->thread);

            luaL_unref(L, LUA_REGISTRYINDEX, thread->function_ref);
            luaL_unref(L, LUA_REGISTRYINDEX, thread->thread_ref);

            list_remove(&lthread_list, idx);
        }

        if (!thid) {
            idx = list_next(&lthread_list, idx);
        } else {
            idx = -1;
        }
    }  
    
    return 0;
}

static int thread_list(lua_State *L) {
    struct lthread *thread;
    int idx;
    char status[5];

    init();
    
    const char *format = luaL_optstring(L, 1, "");

    if (strcmp(format,"*n") == 0) {
        // List only number of current threads
        int n= 0;

        idx = list_first(&lthread_list);
        while (idx >= 0) {
            n++;
            idx = list_next(&lthread_list, idx);
        }       
        
        lua_pushinteger(L, n);
        return 1;
    } else {
        printf("THID\tNAME\t\tSTATUS\tTIME\n");

        // For each lthread in list ...
        idx = list_first(&lthread_list);
        while (idx >= 0) {
            list_get(&lthread_list, idx, &thread);

            // Get status
            switch (thread->status) {
                case LTHREAD_STATUS_RUNNING: strcpy(status,"run "); break;
                case LTHREAD_STATUS_SUSPENDED: strcpy(status,"susp"); break;
                default:
                    strcpy(status,"----");

            }

            printf("%d\t%s\t\t%s\t%d\n", idx, "", status, 0);

            idx = list_next(&lthread_list, idx);
        }        
    }
    
    return 0;
}

// Start a new thread    
static int thread_start(lua_State* L) {
    struct lthread *thread;
    pthread_attr_t attr;
    int res, idx;
    pthread_t id;
    int retries;
    global_State *g;
    
    init();

    // Allocate space for lthread info
    thread = (struct lthread *)malloc(sizeof(struct lthread));
    if (!thread) {
        return luaL_error(L, "not enough memory");
    }
    
    // Check for argument is a function, and store it's reference
    luaL_checktype(L, 1, LUA_TFUNCTION);
    thread->function_ref = luaL_ref(L, LUA_REGISTRYINDEX);
    
    // Create a new state, move function to it and store thread reference
    thread->PL = L;
    thread->L = lua_newthread(L);
    thread->thread_ref = luaL_ref(L, LUA_REGISTRYINDEX);
    thread->status = LTHREAD_STATUS_SUSPENDED;
    
    uxSetLuaState(thread->L);

    lua_rawgeti(L, LUA_REGISTRYINDEX, thread->function_ref);                
    lua_xmove(L, thread->L, 1);

    // Add lthread to list
    res = list_add(&lthread_list, thread, &idx);
    if (res) {
        free(thread);
        return luaL_error(L, "not enough memory");
    }

    // Create pthread
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, configMINIMAL_STACK_SIZE * 20);

    thread->thid = idx;
    
    retries = 0;
    
retry:  
    res = pthread_create(&id, &attr, thread_start_task, thread);
    if (res) {
        if ((res == ENOMEM) && (retries < 4)) {
            luaC_checkGC(L);  /* stack grow uses memory */
            luaD_checkstack(L, LUA_MINSTACK);  /* ensure minimum stack size */
            
            retries++;
            goto retry;
        }
        
        list_remove(&lthread_list, idx);
        
        return luaL_error(L, "can't start pthread (%s)",strerror(errno));
    }

    // Update thread status
    thread->status = LTHREAD_STATUS_RUNNING;
    
    // Store pthread id
    thread->thread = id;            

    // Return lthread id
    lua_pushinteger(L, idx);
    return 1;
}    
     
static int thread_sleep(lua_State* L) {
    int seconds;
    
    init();
    
    // Check argument (seconds)
    seconds = luaL_checkinteger(L, 1);
    
    sleep(seconds);
    
    return 0;
}

static int thread_sleepms(lua_State* L) {
    int milliseconds;
    
    init();
    
    // Check argument (seconds)
    milliseconds = luaL_checkinteger(L, 1);
    
    usleep(milliseconds * 1000);
    
    return 0;
}

static int thread_sleepus(lua_State* L) {
    int useconds;
    
    init();
    
    // Check argument (seconds)
    useconds = luaL_checkinteger(L, 1);
    
    usleep(useconds);
    
    return 0;
}

// Suspend all threads, or a specific thread
static int thread_suspend(lua_State* L) {
    init();
    
    return thread_suspend_pthreads(L, luaL_optinteger(L, 1, 0));    
}

// Resume all threads, or a specific thread
static int thread_resume(lua_State* L) {
    init();
    
    return thread_resume_pthreads(L, luaL_optinteger(L, 1, 0));    
}

// Stop all threads, or a specific thread
static int thread_stop(lua_State* L) {
    init();
    
    return thread_stop_pthreads(L, luaL_optinteger(L, 1, 0));    
}

static int thread_status(lua_State* L) {
    struct lthread *thread;
    int res;
    int thid;
    
    init();
    
    thid = luaL_checkinteger(L, 1);
    
    res = list_get(&lthread_list, thid, &thread);
    if (res) {
        lua_pushnil(L);
        return 1;
    }
    
    switch (thread->status) {
        case LTHREAD_STATUS_RUNNING:   lua_pushstring(L,"running"); break;
        case LTHREAD_STATUS_SUSPENDED: lua_pushstring(L,"suspended"); break;
    }

    return 1;
}

static const luaL_Reg thread[] = {
    {"status", thread_status},
    {"start", thread_start},
    {"suspend", thread_suspend},
    {"resume", thread_resume},
    {"stop", thread_stop},
    {"list", thread_list},
    {"sleep", thread_sleep},
    {"sleepms", thread_sleepms},
    {"sleepus", thread_sleepus},
    {"usleep", thread_sleepus},
    {NULL, NULL}
};

int luaopen_thread(lua_State* L)
{
    luaL_newlib(L, thread);
    return 1;
} 
 