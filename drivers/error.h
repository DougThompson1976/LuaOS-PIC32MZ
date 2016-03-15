#ifndef ERROR_H
#define ERROR_H

#include <drivers/cpu/resource.h>

typedef enum {
    LOCK
} tdriver_error_type;

typedef struct {
    tdriver_error_type type;
    tresource_type resource;
    int resource_unit;
    tresource_owner owner;
    int owner_unit;
} tdriver_error;

#endif

