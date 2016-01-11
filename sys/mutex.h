#ifndef MUTEX_H_H
#define	MUTEX_H_H

#include "FreeRTOS.h"
#include "semphr.h"

#define NMUTEX 24

struct mtx {
    SemaphoreHandle_t sem;
};

void mtx_init(struct mtx *mutex, const char *name, const char *type, int opts);
void mtx_lock(struct mtx *mutex);
int  mtx_trylock(struct	mtx *mutex);
void mtx_unlock(struct mtx *mutex);
void mtx_destroy(struct	mtx *mutex);

#endif	/* MUTEX_H_H */

