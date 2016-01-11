#include "FreeRTOS.h"
#include "event_groups.h"

#include "semphr.h"
#include <sys/mutex.h>
#include <stdlib.h>

#define MTX_DEBUG 0

#if MTX_DEBUG
#define MTX_LOCK_TIMEOUT (portTICK_PERIOD_MS * 3000)
#define MTX_DEBUG_LOCK() printf("mtx can't lock\n");
#else
#define MTX_LOCK_TIMEOUT portMAX_DELAY
#define MTX_DEBUG_LOCK() 
#endif

static EventGroupHandle_t groups[NMUTEX];
static int free_mtx[NMUTEX];
static SemaphoreHandle_t sem;

void _mtx_init() {
    int i;
    
    sem = xSemaphoreCreateBinary();
    xSemaphoreGive(sem);
    
    for(i=0;i < NMUTEX; i++) {
        free_mtx[i] = 0b111111111111111111111111;
        groups[i] = xEventGroupCreate();
        xEventGroupClearBits(groups[i], 0b111111111111111111111111);
    }
}

int _mtx_init_mtx() {
    int i, bit = 0;
    
    if (xSemaphoreTake(sem, MTX_LOCK_TIMEOUT) != pdTRUE) {
        for(i=0;i < NMUTEX; i++) {
            printf("%x\n", free_mtx[i]);
            
            bit = ffs(free_mtx[i]);
            
            printf("bit %d\n",bit);
            if (bit) {
                free_mtx[i] &= ~(1 << (bit - 1));
                bit = bit + i * 24;
                break;
            }
        }
    }

    xSemaphoreGive(sem);   
    
    return bit;
}

void _mtx_free_mtx(int bit) {    
    if (xSemaphoreTake(sem, MTX_LOCK_TIMEOUT) != pdTRUE) {
        int group = bit / 24;

        bit = bit % 24;
        xEventGroupClearBits(groups[group], (1 << (bit - 1)));
        free_mtx[group] |= (1 << (bit - 1));
    }
    
    xSemaphoreGive(sem);
}

void mtx_init(struct mtx *mutex, const char *name, const char *type, int opts) {    
    mutex->sem = xSemaphoreCreateBinary();
    if (mutex->sem) {
        if (uxInterruptNesting > 0) {
            BaseType_t xHigherPriorityTaskWoken = pdFALSE;
            xSemaphoreGiveFromISR( mutex->sem, &xHigherPriorityTaskWoken); 
            portEND_SWITCHING_ISR( xHigherPriorityTaskWoken );
        } else {
            xSemaphoreGive( mutex->sem );            
        }
    }    
}

void mtx_lock(struct mtx *mutex) {
    if (uxInterruptNesting > 0) {
        BaseType_t xHigherPriorityTaskWoken = pdFALSE;        
        xSemaphoreTakeFromISR( mutex->sem, &xHigherPriorityTaskWoken );
        portEND_SWITCHING_ISR( xHigherPriorityTaskWoken );
    } else {
        if (xSemaphoreTake( mutex->sem, MTX_LOCK_TIMEOUT ) != pdTRUE) {
            MTX_DEBUG_LOCK();
        }
    }
}

int mtx_trylock(struct	mtx *mutex) {
    if (xSemaphoreTake( mutex->sem, 0 ) == pdTRUE) {
        return 1;
    } else {
        return 0;
    }
}

void mtx_unlock(struct mtx *mutex) {
    if (uxInterruptNesting > 0) {
        BaseType_t xHigherPriorityTaskWoken = pdFALSE;  
        xSemaphoreGiveFromISR( mutex->sem, &xHigherPriorityTaskWoken );  
        portEND_SWITCHING_ISR( xHigherPriorityTaskWoken );
    } else {
        xSemaphoreGive( mutex->sem );    
    }
}

void mtx_destroy(struct	mtx *mutex) {
    if (uxInterruptNesting > 0) {
        BaseType_t xHigherPriorityTaskWoken = pdFALSE;  
        xSemaphoreGiveFromISR( mutex->sem, &xHigherPriorityTaskWoken );  
        portEND_SWITCHING_ISR( xHigherPriorityTaskWoken );
    } else {
        xSemaphoreGive( mutex->sem );        
    }
    
    vSemaphoreDelete( mutex->sem );
}
