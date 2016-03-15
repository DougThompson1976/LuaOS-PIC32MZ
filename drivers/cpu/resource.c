#include <sys/mutex.h>

#include <drivers/cpu/resource.h>

static struct mtx resource_mtx;

static tresource_lock resource_timer[9];

static tresource_lock *resource_lock_array(tresource_type type) {
    switch (type) {
        case TIMER: return resource_timer;
    }
}

static int resource_lock_array_len(tresource_type type) {
    switch (type) {
        case TIMER: return 9;
    }
}

void resource_init() {
    int i;
    
    mtx_init(&resource_mtx, NULL, NULL, 0);
    
    // All timers are free, except timer 1, used by system
    for(i=0;i<9;i++) {
        resource_timer[i].owner = FREE;
    }
    resource_timer[0].owner = SYSTEM;
    resource_timer[0].unit = 0;
}

tresource_lock *resource_lock(tresource_type type, int resource_unit, tresource_owner owner, int owner_unit) {
    tresource_lock *lock_array = resource_lock_array(type);
    tresource_lock *lock;
    
    mtx_lock(&resource_mtx);
    
    if (resource_unit == - 1) {
        // Find a free resource
        int lock_array_len = resource_lock_array_len(type);
        
        for(resource_unit = 0; resource_unit < lock_array_len; resource_unit++) {
            if (lock_array[resource_unit].owner == FREE) {
                lock_array[resource_unit].owner = owner;
                lock_array[resource_unit].unit = owner_unit;
                
                break;
            }            
        }
        
        if (resource_unit == lock_array_len) {
            // Not a free resource
            mtx_unlock(&resource_mtx);
            return NULL;
        }

        lock = (tresource_lock *)malloc(sizeof(tresource_lock));

        lock->owner = lock_array[resource_unit].owner;
        lock->unit = resource_unit;
    } else {
        if (lock_array[resource_unit].owner == FREE) {
            lock_array[resource_unit].owner = owner;
            lock_array[resource_unit].unit = owner_unit;
        }

        lock = (tresource_lock *)malloc(sizeof(tresource_lock));
    
        lock->owner = lock_array[resource_unit].owner;
        lock->unit = lock_array[resource_unit].unit;
    }
    
    mtx_unlock(&resource_mtx);
    
    return lock;
}

int resource_unlock(tresource_type type, int unit) {
    mtx_lock(&resource_mtx);
    mtx_unlock(&resource_mtx);    
}

const char *resource_name(tresource_type type) {
    switch (type) {
        case GPIO:  return "pin";
        case TIMER: return "timer";
    }
    
    return "";
}

const char *owner_name(tresource_owner owner) {
    switch (owner) {
        case SYSTEM:  return "LuaOS";
        case STEPPER: return "stepper";
        case PWM: return "pwm";
    }
    
    return "";
}