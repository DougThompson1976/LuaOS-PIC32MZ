#include "FreeRTOS.h"
#include "lua.h"

extern lua_State *gLuaState;

void *malloc(size_t len) {
    void *p;
    
    p = (void *)pvPortMalloc(len);
    if (!p) {
        if (gLuaState) {
           luaC_fullgc(gLuaState, 1);
           p = pvPortMalloc(len);
        }
    }        
    
    return p;
}

void free(void *cp) {
    vPortFree(cp);
}

void *realloc(void *ptr, size_t size) {
    void *p;
    
    // If ptr is NULL, then the call is equivalent to malloc(size), for all 
    // values of size
    if (!ptr) {
        return malloc(size);
    }
    
    // If size is equal to zero, and ptr is not NULL, then the call is 
    // equivalent to free(ptr)
    if ((size == 0) && (ptr)) {
        free(ptr);
        return NULL;
    }
    
    // Realloc
    p = (void *)pvPortRealloc(ptr, size);
    if (!p) {
        if (gLuaState) {
           luaC_fullgc(gLuaState, 1);
           p = (void *)pvPortRealloc(ptr, size);
        }
    }
    
    return p;
}