#include <time.h>
#include "drivers/clock/clock.h"

clock_t clock(void) {
    return ticks();
}
