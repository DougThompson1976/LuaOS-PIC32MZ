/*******************************************************************************
 * Copyright (c) 2009, 2014 IBM Corp.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution. 
 *
 * The Eclipse Public License is available at 
 *    http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at 
 *   http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 *    Ian Craggs - initial implementation
 *    Ian Craggs, Allan Stockdill-Mander - async client updates
 *    Ian Craggs - bug #415042 - start Linux thread as disconnected
 *    Ian Craggs - fix for bug #420851
 *******************************************************************************/

/**
 * @file
 * \brief Threading related functions
 *
 * Used to create platform independent threading functions
 */

// WHITECAT BEGIN
#include "whitecat.h"
// WHITECAT END

#include "Thread.h"
#if defined(THREAD_UNIT_TESTS)
#define NOSTACKTRACE
#endif
#include "StackTrace.h"

#undef malloc
#undef realloc
#undef free

#if !defined(WIN32) && !defined(WIN64)
#include <errno.h>
#include <unistd.h>
#include <sys/time.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <limits.h>
#endif
#include <memory.h>
#include <stdlib.h>

/**
 * Start a new thread
 * @param fn the function to run, must be of the correct signature
 * @param parameter pointer to the function parameter, can be NULL
 * @return the new thread
 */
thread_type Thread_start(thread_fn fn, void* parameter)
{
#if defined(WIN32) || defined(WIN64)
	thread_type thread = NULL;
#else
	thread_type thread = 0;
	pthread_attr_t attr;
#endif

	FUNC_ENTRY;
#if defined(WIN32) || defined(WIN64)
	thread = CreateThread(NULL, 0, fn, parameter, 0, NULL);
#else
	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
        
        // WHITECAT BEGIN
        pthread_attr_setstacksize(&attr, mqttStack);
        // WHITECAT END

	if (pthread_create(&thread, &attr, fn, parameter) != 0)
		thread = 0;
	pthread_attr_destroy(&attr);
#endif
	FUNC_EXIT;
	return thread;
}


/**
 * Create a new mutex
 * @return the new mutex
 */
mutex_type Thread_create_mutex()
{
	mutex_type mutex = NULL;
	int rc = 0;

	FUNC_ENTRY;
	#if defined(WIN32) || defined(WIN64)
		mutex = CreateMutex(NULL, 0, NULL);
	#else
		mutex = malloc(sizeof(pthread_mutex_t));
		rc = pthread_mutex_init(mutex, NULL);
	#endif
	FUNC_EXIT_RC(rc);
	return mutex;
}


/**
 * Lock a mutex which has already been created, block until ready
 * @param mutex the mutex
 * @return completion code, 0 is success
 */
int Thread_lock_mutex(mutex_type mutex)
{
	int rc = -1;

	/* don't add entry/exit trace points as the stack log uses mutexes - recursion beckons */
	#if defined(WIN32) || defined(WIN64)
		/* WaitForSingleObject returns WAIT_OBJECT_0 (0), on success */
		rc = WaitForSingleObject(mutex, INFINITE);
	#else
		rc = pthread_mutex_lock(mutex);
	#endif

	return rc;
}


/**
 * Unlock a mutex which has already been locked
 * @param mutex the mutex
 * @return completion code, 0 is success
 */
int Thread_unlock_mutex(mutex_type mutex)
{
	int rc = -1;

	/* don't add entry/exit trace points as the stack log uses mutexes - recursion beckons */
	#if defined(WIN32) || defined(WIN64)
		/* if ReleaseMutex fails, the return value is 0 */
		if (ReleaseMutex(mutex) == 0)
			rc = GetLastError();
		else
			rc = 0;
	#else
		rc = pthread_mutex_unlock(mutex);
	#endif

	return rc;
}


/**
 * Destroy a mutex which has already been created
 * @param mutex the mutex
 */
void Thread_destroy_mutex(mutex_type mutex)
{
	int rc = 0;

	FUNC_ENTRY;
	#if defined(WIN32) || defined(WIN64)
		rc = CloseHandle(mutex);
	#else
		rc = pthread_mutex_destroy(mutex);
		free(mutex);
	#endif
	FUNC_EXIT_RC(rc);
}


/**
 * Get the thread id of the thread from which this function is called
 * @return thread id, type varying according to OS
 */
thread_id_type Thread_getid()
{
	#if defined(WIN32) || defined(WIN64)
		return GetCurrentThreadId();
	#else
		return pthread_self();
	#endif
}

/**
 * Create a new semaphore
 * @return the new condition variable
 */
sem_type Thread_create_sem()
{
	sem_type sem = NULL;
	int rc = 0;

	FUNC_ENTRY;
    
        rc = sys_sem_new(&sem, 0);
            
	FUNC_EXIT_RC(rc);
	return sem;
}


/**
 * Wait for a semaphore to be posted, or timeout.
 * @param sem the semaphore
 * @param timeout the maximum time to wait, in milliseconds
 * @return completion code
 */
int Thread_wait_sem(sem_type sem, int timeout)
{
    u32_t rc = -1;

    FUNC_ENTRY;
    
    rc = sys_arch_sem_wait(sem, timeout);
        
    if (rc == 0xffffffffUL) {
        rc = -1;
    } else {
        rc = 0;
    }

    FUNC_EXIT_RC((int)rc);
    return (int)rc;
}


/**
 * Check to see if a semaphore has been posted, without waiting.
 * @param sem the semaphore
 * @return 0 (false) or 1 (true)
 */
int Thread_check_sem(sem_type sem)
{
    if (xSemaphoreTake(sem,0) == pdTRUE) {
        xSemaphoreGive(sem);
        
        return 1;
    } else {
        return 0;
    }
    return 0;
}


/**
 * Post a semaphore
 * @param sem the semaphore
 * @return completion code
 */
int Thread_post_sem(sem_type sem)
{
    int rc = 0;

    FUNC_ENTRY;

    sys_sem_signal(sem);

    FUNC_EXIT_RC(rc);
    
    return rc;
}


/**
 * Destroy a semaphore which has already been created
 * @param sem the semaphore
 */
int Thread_destroy_sem(sem_type sem)
{
    int rc = 0;

    FUNC_ENTRY;

    sys_sem_free(sem);
    
    FUNC_EXIT_RC(rc);
    
    return rc;
}


#if !defined(WIN32) && !defined(WIN64)
/**
 * Create a new condition variable
 * @return the condition variable struct
 */
cond_type Thread_create_cond()
{
//	cond_type condvar = NULL;
//	int rc = 0;
//
//	FUNC_ENTRY;
//	condvar = malloc(sizeof(cond_type_struct));
//	rc = pthread_cond_init(&condvar->cond, NULL);
//	rc = pthread_mutex_init(&condvar->mutex, NULL);
//
//	FUNC_EXIT_RC(rc);
//	return condvar;
}

/**
 * Signal a condition variable
 * @return completion code
 */
int Thread_signal_cond(cond_type condvar)
{
//	int rc = 0;
//
//	pthread_mutex_lock(&condvar->mutex);
//	rc = pthread_cond_signal(&condvar->cond);
//	pthread_mutex_unlock(&condvar->mutex);
//
//	return rc;
}

/**
 * Wait with a timeout (seconds) for condition variable
 * @return completion code
 */
int Thread_wait_cond(cond_type condvar, int timeout)
{
//	FUNC_ENTRY;
//	int rc = 0;
//	struct timespec cond_timeout;
//	struct timeval cur_time;
//
//	gettimeofday(&cur_time, NULL);
//
//	cond_timeout.tv_sec = cur_time.tv_sec + timeout;
//	cond_timeout.tv_nsec = cur_time.tv_usec * 1000;
//
//	pthread_mutex_lock(&condvar->mutex);
//	rc = pthread_cond_timedwait(&condvar->cond, &condvar->mutex, &cond_timeout);
//	pthread_mutex_unlock(&condvar->mutex);
//
//	FUNC_EXIT_RC(rc);
//	return rc;
}

/**
 * Destroy a condition variable
 * @return completion code
 */
int Thread_destroy_cond(cond_type condvar)
{
//	int rc = 0;
//
//	rc = pthread_mutex_destroy(&condvar->mutex);
//	rc = pthread_cond_destroy(&condvar->cond);
//	free(condvar);
//
//	return rc;
}
#endif