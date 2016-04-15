#ifndef RESOURCE_H
#define RESOURCE_H

typedef enum {GPIO, TIMER} tresource_type;
typedef enum {FREE, SYSTEM, STEPPER, PWM} tresource_owner;

typedef struct {
    tresource_owner owner;
    int unit;
    int granted;
    int id;
} tresource_lock;

void resource_init();
tresource_lock *resource_lock(tresource_type type, int resource_unit, tresource_owner owner, int owner_unit);

const char *resource_name(tresource_type type);
const char *resource_unit_name(tresource_type type, int unit);
const char *owner_name(tresource_owner owner);

#endif

