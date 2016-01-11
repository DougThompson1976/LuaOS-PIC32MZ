// Platform-dependent functions

#include "elua_platform.h"
#include "type.h"
//#include "devman.h"
//#include "genstd.h"
#include "stacks.h"
//#include <reent.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include "utils.h"
#include "elua_adc.h"
#include "platform_conf.h"
#include "common.h"
#include "buf.h"

#include <sys/types.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <locale.h>

//#include "ff.h"
#include "drivers/clock/clock.h"
#include "drivers/gpio/gpio.h"
#include "drivers/spi/spi.h"
#include "drivers/uart/uart.h"
#include "drivers/can/can.h"
#include "utils/delay.h"

#include "semphr.h"



void platform_s_uart_send( unsigned id, u8 data ) {
    uart_write(id, (char)data);
}

int platform_s_uart_recv( unsigned id, timer_data_type timeout ) {
    char c;
    
    uart_read(id, &c, portMAX_DELAY);
    return c;
}

int platform_s_uart_set_flow_control( unsigned id, int type ) {
    return 0;
}



u32 platform_i2c_setup( unsigned id, u32 speed ) {
    return 0;
}

void platform_i2c_send_start( unsigned id ) {
}

void platform_i2c_send_stop( unsigned id ) {
}

int platform_i2c_send_address( unsigned id, u16 address, int direction ) {
    return 0;
}

int platform_i2c_send_byte( unsigned id, u8 data ) {
    return 0;
}

int platform_i2c_recv_byte( unsigned id, int ack ) {
    return 0;
}

timer_data_type platform_timer_read_sys(void) {
    return ReadCoreTimer();
}

u64 platform_timer_sys_raw_read(void) {
    return 0;
}

void platform_timer_sys_enable_int(void) {

}

void platform_timer_sys_disable_int(void) {
    
}

void platform_s_timer_delay( unsigned id, timer_data_type delay_us ) {

}

timer_data_type platform_s_timer_op( unsigned id, int op, timer_data_type data ) {
    return 0;
}


int platform_cpu_set_global_interrupts( int status ) {
    return 0;
}
