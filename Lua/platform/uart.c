#include "elua_platform.h"
#include "platform_conf.h"

#include <drivers/uart/uart.h>

int platform_uart_exists( unsigned id ) {
    return ((id > 0) && (id <= NUART));
}

int platform_uart_pins( lua_State* L ) {
    int i;
    unsigned char rx, tx;
    
    for(i=1;i<=NUART;i++) {
        uart_pins(i, &rx, &tx);

        if ((rx != 0) && (tx != 0)) {
            printf(
                "uart%d: rx=%c%d\t(pin %2d)\ttx=%c%d\t(pin %2d)\n", i,
                gpio_portname(rx), gpio_pinno(rx),cpu_pin_number(rx),
                gpio_portname(tx), gpio_pinno(tx),cpu_pin_number(tx)
            );            
        }
    }
    
    return 0;
}

int platform_uart_setup(lua_State* L, int id, int bauds, int databits, int parity, int stop_bits, int buffer) {
    int mode = 0;
    
    if ((databits == 8) && (parity == 0)) {
        mode = PIC32_UMODE_PDSEL_8NPAR;
    } else if ((databits == 8) && (parity == 1)) {
        mode = PIC32_UMODE_PDSEL_8EVEN;
    } else if ((databits == 8) && (parity == 2)) {
        mode = PIC32_UMODE_PDSEL_8ODD;
    } else if ((databits == 9) && (parity == 0)) {
        mode = PIC32_UMODE_PDSEL_9NPAR;
    } else {
        return luaL_error(L, "invalid data bits / parity combination");               
    }    

    uart_init(id, bauds, mode, buffer);
    uart_init_interrupts(id);
    
    return uart_get_br(id);
} 

void platform_uart_write_byte(int id, int c) {
    uart_write(id, c);
}

void platform_uart_write_string(int id, const char *s) {
    uart_writes(id, (char *)s);
}

int platform_uart_read_string(int id, char *str, int crlf, int timeout) {    
    if (timeout == 0xffffffff) {
        timeout = portMAX_DELAY;
    }
    
    return uart_reads(id, str, crlf, timeout);
}

int platform_uart_read_char(int id, char *c, int timeout) {    
    if (timeout == 0xffffffff) {
        timeout = portMAX_DELAY;
    }
    
    return uart_read(id, c, timeout);
}