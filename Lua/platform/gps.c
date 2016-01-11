#include "elua_platform.h"
#include "platform_conf.h"

#include <drivers/sim908/sim908.h>

int platform_gps_start() {
    sim908_init(0, 1);
    
    return 1;
}

int platform_gps_stop() {
    
}
