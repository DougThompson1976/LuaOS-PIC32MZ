/*
 * Whitecat, pthread implementation ober FreeRTOS
 *
 * Copyright (C) 2015
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.com)
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

#include <errno.h>
#include <lib/list/list.h>

extern struct list mutex_list;

static int _check_attr(const pthread_mutexattr_t *attr) {
    int type = attr->type;
        
    if ((type < PTHREAD_MUTEX_NORMAL) || (type > PTHREAD_MUTEX_DEFAULT)) {
        return EINVAL;
    }
   
   return 0;
}

int pthread_mutex_init(pthread_mutex_t *mut, const pthread_mutexattr_t *attr) {
    struct pthread_mutex *mutex;
    int res;

    if (!attr) {
        return EINVAL;
    }
    
    // Check attr
    res = _check_attr(attr);
    if (res) {
        return res;
    }

    // Init library, if needed
    _pthread_init();

    // Test if it's init yet
    res = list_get(&mutex_list, *mut, &mutex);
    if (!res) {
        return EBUSY;
    }

    // Create mutex structure
    mutex = (struct pthread_mutex *)malloc(sizeof(struct pthread_mutex));
    if (!mutex) {
        return EINVAL;
    }

    mutex->type = attr->type;

    // Create semaphore
    if (mutex->type == PTHREAD_MUTEX_RECURSIVE) {
        mutex->sem = xSemaphoreCreateRecursiveMutex();    
    } else {
        mutex->sem = xSemaphoreCreateMutex();
    }
    if(!mutex->sem){
        *mut = 0;
        free(mutex->sem);
        return ENOMEM;
    }
    
    mutex->owner = pthread_self();
    
    // Add mutext to the list
    res = list_add(&mutex_list, mutex, mut);
    if (res) {
        free(mutex->sem);
        vSemaphoreDelete(mutex->sem);
        
        return res;
    }

    return 0;    
}

int pthread_mutex_lock(pthread_mutex_t *mut) {
    struct pthread_mutex *mutex;
    int res;
    
    // Init library, if needed
    _pthread_init();
    
    // Get mutex
    res = list_get(&mutex_list, *mut, &mutex);
    if (res) {
        return res;
    }
    
    // Lock
    if (mutex->type == PTHREAD_MUTEX_RECURSIVE) {
        if (xSemaphoreTakeRecursive(mutex->sem, PTHREAD_MTX_LOCK_TIMEOUT) != pdPASS) {
            PTHREAD_MTX_DEBUG_LOCK();
            return EINVAL;
        }
    } else {
        if (xSemaphoreTake(mutex->sem, PTHREAD_MTX_LOCK_TIMEOUT) != pdPASS) {
            PTHREAD_MTX_DEBUG_LOCK();
            return EINVAL;
        }        
    }
    
    return 0;
}

int pthread_mutex_unlock(pthread_mutex_t *mut) {
    struct pthread_mutex *mutex;
    int res;

    // Init library, if needed
    _pthread_init();

    // Get mutex
    res = list_get(&mutex_list, *mut, &mutex);
    if (res) {
        return res;
    }
    
    // Unlock
    if (mutex->type == PTHREAD_MUTEX_RECURSIVE) {
        xSemaphoreGiveRecursive(mutex->sem);        
    } else {
        xSemaphoreGive(mutex->sem);        
    }
    
    return 0;
}

int pthread_mutex_trylock(pthread_mutex_t *mut) {
    struct pthread_mutex *mutex;
    int res;
    
    // Init library, if needed
    _pthread_init();
    
    // Get mutex
    res = list_get(&mutex_list, *mut, &mutex);
    if (res) {
        return res;
    }
    
    // Try lock
    if (mutex->type == PTHREAD_MUTEX_RECURSIVE) {
        if (xSemaphoreTakeRecursive(mutex->sem,0 ) != pdTRUE) {
            return EBUSY;
        }
    } else {
        if (xSemaphoreTake(mutex->sem,0 ) != pdTRUE) {
            return EBUSY;
        }
    }
    
    return 0;
}

int pthread_mutex_destroy(pthread_mutex_t *mut) {
    struct pthread_mutex *mutex;
    int res;
    
    // Init library, if needed
    _pthread_init();
    
    // Get mutex
    res = list_get(&mutex_list, *mut, &mutex);
    if (res) {
        return res;
    }

    xSemaphoreGive(mutex->sem);        
    vSemaphoreDelete(mutex->sem);

    return 0;
}

int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type) {
    pthread_mutexattr_t temp_attr;
    int res;

    // Check attr
    if (!attr) {
        return EINVAL;
    }

    temp_attr.type = type;
    
    res = _check_attr(&temp_attr);
    if (res) {
        return res;
    }

    // Init library, if needed
    _pthread_init();

    attr->type = type;
    
    return 0;
}

int pthread_mutexattr_init(pthread_mutexattr_t *attr) {
    // Init library, if needed
    _pthread_init();

    attr->type = PTHREAD_MUTEX_NORMAL;
    
    return 0;
}