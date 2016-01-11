#include "FreeRTOS.h"
#include "pthread.h"

#if 0

static pthread_key_t key;
static pthread_once_t key_once = PTHREAD_ONCE_INIT;

static void make_key() {
    printf("make_key from id %d\n", pthread_self());    
    
    pthread_key_create(&key, NULL);
}
  
void *f1(void *arg) {
    int *ptr;
    int i;
    
    pthread_once(&key_once, make_key);
    if ((ptr = pthread_getspecific(key)) == NULL) {
        ptr = (int *)malloc(sizeof(int));
        *ptr = 5;
        pthread_setspecific(key, ptr);
    }
     
    printf("f1: thread id %d, its %d\n", pthread_self(),*ptr);
    
    for(i=1;i<*ptr;i++) {
        printf("f1: %d\n", i);
        delay(100);
    }    
}

void *f2(void *arg) {
    int *ptr;
    int i;
    
    pthread_once(&key_once, make_key);
    if ((ptr = pthread_getspecific(key)) == NULL) {
        ptr = (int *)malloc(sizeof(int));
        *ptr = 10;
        pthread_setspecific(key, ptr);
    }

    printf("f2: thread id %d, its %d\n", pthread_self(),*ptr);

    for(i=1;i<*ptr;i++) {
        printf("f2: %d\n", i);
        delay(100);
    }
}

void pthread_test1() {
    pthread_attr_t attr;
    pthread_t t1;
    pthread_t t2;
    int err;
    
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, configMINIMAL_STACK_SIZE * 10);
    
    err = pthread_create(&t1, &attr, &f1, NULL);
    if (err) {
        printf("can't create thread 1 %d", err);
    }

    
    err = pthread_create(&t2, &attr, &f2, NULL);
    if (err) {
        printf("can't create thread 2 %d", err);
    }

    err = pthread_join(t1, NULL);
    if (err) {
        printf("join thread 1 failed\n");
    }
    
    printf("thread 1 ended\n");

    err = pthread_join(t2, NULL);
    if (err) {
        printf("join thread 2 failed\n");
    }

    printf("thread 2 ended\n");
}

#endif
