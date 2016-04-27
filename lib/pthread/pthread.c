/*
 * Whitecat, pthread implementation over FreeRTOS
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

#include <sys/mutex.h>
#include <errno.h>

#include <sys/queue.h>

extern void uxSetThreadId(UBaseType_t id);

struct list key_list;
struct list mutex_list;
struct list thread_list;

struct mtx once_mtx;
struct mtx cond_mtx;

struct pthreadTaskArg {
    void *(*pthread_function) (void *);
    void *args;
    int id;
};
  
void pthreadTask(void *task_arguments);

void _pthread_init() {
    // Create mutexes
    mtx_init(&once_mtx, NULL, NULL, 0);
    mtx_init(&cond_mtx, NULL, NULL, 0);
    
    // Init lists
    list_init(&thread_list, 1);
    list_init(&mutex_list, 1);
    list_init(&key_list, 1);
}

int _pthread_create(pthread_t *id, int stacksize, 
                    void *(*start_routine)(void *), void *args
) {
    xTaskHandle xCreatedTask;              // Related task
    struct pthreadTaskArg *taskArgs;
    BaseType_t res;
    struct pthread *thread;
    struct pthread *parent_thread;
    char name[configMAX_TASK_NAME_LEN];
    int current_thread, i;
    
    // Set pthread arguments for creation
    taskArgs = (struct pthreadTaskArg *)malloc(sizeof(struct pthreadTaskArg));
    if (!taskArgs) {
        errno = EAGAIN;
        return EAGAIN;
    }
                
    taskArgs->pthread_function = start_routine;
    taskArgs->args = args;

    // Create thread structure
    thread = (struct pthread *)malloc(sizeof(struct pthread));
    if (!thread) {
        free(taskArgs);
        errno = EAGAIN;
        return EAGAIN;
    }
    
    for(i=0; i < NSIG; i++) {
        thread->signals[i] = SIG_DFL;
    }
    
    current_thread = pthread_self();
    if (current_thread > 0) {
        // Get parent thread
        res = list_get(&thread_list, current_thread, &parent_thread);
        if (res) {
            free(taskArgs);
            errno = EAGAIN;
            return EAGAIN;
        }
        
        // Copy signals to new thread
        bcopy(parent_thread->signals, thread->signals, sizeof(sig_t) * NSIG);
    }
    
    list_init(&thread->join_list, 1);
    list_init(&thread->clean_list, 1);
    
    mtx_init(&thread->init_mtx, NULL, NULL, 0);

    // Add to the thread list
    res = list_add(&thread_list, thread, id);
    if (res) {
        free(taskArgs);
        free(thread);
        errno = EAGAIN;
        return EAGAIN;
    }

    taskArgs->id = *id;
    thread->thread = *id;
    
    // Set taskname
    sprintf(name,"thread%d",*id);

    mtx_lock(&thread->init_mtx);

    // Create related task
    res = xTaskCreate(
            pthreadTask, name, stacksize, taskArgs, 
            tskDEF_PRIORITY, &xCreatedTask
    );
   
    if(res != pdPASS) {
        // Remove from thread list
        list_remove(&thread_list,*id);
        free(taskArgs);
        free(thread);

        if (res == errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY) {
            errno = ENOMEM;
            return ENOMEM;
        } else {
            errno = EAGAIN;
            return EAGAIN;
        }
    }
    
    mtx_lock(&thread->init_mtx);
    
    thread->task = xCreatedTask;

    return 0;
}

int _pthread_join(pthread_t id) {
    struct pthread_join *join;
    struct pthread *thread;
    int idx;
    int res;
    char c;

    // Get thread
    res = list_get(&thread_list, id, &thread);
    if (res) {
        errno = res;
        return res;
    }
    
    // Create join structure
    join = (struct pthread_join *)malloc(sizeof(struct pthread_join));
    if (!join) {
        errno = ESRCH;
        return ESRCH;
    }
    
    // Create a queue
    join->queue = xQueueCreate(1, sizeof(char));
    if (join->queue == 0) {
        free(join);
        errno = ESRCH;
        return ESRCH;            
    }

    // Add join to the join list
    res = list_add(&thread->join_list, join, &idx); 
    if (res) {
        vQueueDelete(join->queue);
        free(join);
        errno = ESRCH;
        return ESRCH;
    }

    // Wait
    xQueueReceive(join->queue,&c,portMAX_DELAY);
        
    return 0;
} 

int _pthread_free(pthread_t id) {
    struct pthread *thread;
    struct pthread_join *join;  // Current join
    int res;
    
    // Get thread
    res = list_get(&thread_list, id, &thread);
    if (res) {
        errno = res;
        return res;
    }

    // Free join list
    list_destroy(&thread->join_list, 1);

    // Free clean list
    list_destroy(&thread->clean_list, 1);
    
    mtx_destroy(&thread->init_mtx);
    
    // Remove thread
    list_remove(&thread_list, id);
    
    return 0;
}

sig_t _pthread_signal(int s, sig_t h) {
    struct pthread *thread; // Current thread
    sig_t prev_h;           // Previous handler
    
    if (s > NSIG) {
        errno = EINVAL;
        return SIG_ERR;
    }
    
    // Get thread
    list_get(&thread_list, pthread_self(), &thread);
    
    // Add handler
    prev_h = thread->signals[s];
    thread->signals[s] = h;
    
    return prev_h;
}

int _pthread_do_signal(int s) {
    struct pthread *thread;      // Current thread
    int index;
    int done = 0;
    
    index = list_first(&thread_list);
    while (index >= 0) {
        list_get(&thread_list, index, &thread);
        
        if (thread->thread == 1) {
            if ((thread->signals[s] != SIG_DFL) && (thread->signals[s] != SIG_IGN)) {
                thread->signals[s](s);
                done = 1;
            }            
        }
        
        index = list_next(&thread_list, index);
    }    

    return done;
}

int _pthread_stop(pthread_t id) {
    struct pthread *thread;
    int res;

    // Get thread
    res = list_get(&thread_list, id, &thread);
    if (res) {
        errno = res;
        return res;
    }
    
    // Stop
    vTaskDelete(thread->task);
    
    return 0;
}

int _pthread_suspend(pthread_t id) {
    struct pthread *thread;
    int res;

    // Get thread
    res = list_get(&thread_list, id, &thread);
    if (res) {
        errno = res;
        return res;
    }
    
    // Stop
    vTaskSuspend(thread->task);
    
    return 0;
}

int _pthread_resume(pthread_t id) {
    struct pthread *thread;
    int res;

    // Get thread
    res = list_get(&thread_list, id, &thread);
    if (res) {
        errno = res;
        return res;
    }
        
    // Stop
    vTaskResume(thread->task);

    return 0;
}

void pthreadTask(void *taskArgs) {
    struct pthreadTaskArg *args; // Task arguments
    struct pthread_join *join;   // Current join
    struct pthread_clean *clean; // Current clean
    struct pthread *thread;      // Current thread
    char c = '1';
    int index;
        
    args = (struct pthreadTaskArg *)taskArgs;

    // Get thread
    list_get(&thread_list, args->id, &thread);

    // Set thread id
    uxSetThreadId(args->id);

    mtx_unlock(&thread->init_mtx);

    // Call start function
    args->pthread_function(args->args);

    // Inform from thread end to joined threads
    index = list_first(&thread->join_list);
    while (index >= 0) {
        list_get(&thread->join_list, index, &join);
                
        xQueueSend(join->queue,&c, portMAX_DELAY);
        
        index = list_next(&thread->join_list, index);
    }

    // Execute clean list
    index = list_first(&thread->clean_list);
    while (index >= 0) {
        list_get(&thread->clean_list, index, &clean);
         
        if (clean->clean) {
            (*clean->clean)(clean->args);
            free(clean->args);
        }
        
        index = list_next(&thread->clean_list, index);
    }
    
    // Free thread structures
    _pthread_free(args->id);

    // Free args
    free(taskArgs);
        
    // End related task
    vTaskDelete(NULL);
}