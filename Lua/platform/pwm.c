#include <drivers/pwm/pwm.h>

int platform_pwm_exists(int id) {
    return ((id > 0) && (id <= NOC));
}

int platform_pwm_setup_freq(int id, int khz, double duty) {
    // Setup in base of frequency
    pwm_init_freq(id, khz, duty);
    
    // Return real frequency
    return pwm_freq(id);
}

int platform_pwm_setup_res(int id, int res, int val) {
    // Setup in base of resolution
    pwm_init_res(id, res, val);
    
    // Return real frequency
    return pwm_freq(id);
}

void platform_pwm_start(int id) {
    pwm_start(id);
}

void platform_pwm_stop(int id) {
    pwm_stop(id);
}

void platform_pwm_set_duty(int id, double duty) {
    pwm_set_duty(id, duty);
}

void platform_pwm_write(int id, int res, int value) {
    pwm_write(id, res, value);
}