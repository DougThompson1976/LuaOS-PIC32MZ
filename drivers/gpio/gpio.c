/*
 * GPIO driver for pic32.
 *
 * Copyright (C) 2014 Serge Vakulenko, <serge@vak.ru>
 * Copyright (C) 2015 - 2016 Jaume Olivé, <jolive@iberoxarxa.com>
 * 
 * Whitecat, gpio driver
 *
 * Copyright (C) 2015 - 2016
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.org)
 * 
 * All rights reserved.  
 *
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both that the copyright notice and this
 * permission notice and warranty disclaimer appear in supporting
 * documentation, and that the name of the author not be used in
 * advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * The author disclaim all warranties with regard to this
 * software, including all implied warranties of merchantability
 * and fitness.  In no event shall the author be liable for any
 * special, indirect or consequential damages or any damages
 * whatsoever resulting from loss of use, data or profits, whether
 * in an action of contract, negligence or other tortious action,
 * arising out of or in connection with the use or performance of
 * this software.
 */

#include "whitecat.h"

#include "drivers/gpio/gpio.h"

#include <syslog.h>

const char pin_name[16] = "?ABCDEFGHJK?????";

int gpio_input_map1(int pin)
{
    switch (pin) {
        case RP('D',2):  return 0;
        case RP('G',8):  return 1;
        case RP('F',4):  return 2;
        case RP('D',10): return 3;
        case RP('F',1):  return 4;
        case RP('B',9):  return 5;
        case RP('B',10): return 6;
        case RP('C',14): return 7;
        case RP('B',5):  return 8;
        case RP('C',1):  return 10;
        case RP('D',14): return 11;
        case RP('G',1):  return 12;
        case RP('A',14): return 13;
        case RP('D',6):  return 14;
    }
    syslog(LOG_ERR, "gpio: cannot map peripheral input pin %c%d, group 1",
        pin_name[pin>>4], pin & 15);
    return -1;
}

int gpio_input_map2(int pin)
{
    switch (pin) {
    case RP('D',3):  return 0;
    case RP('G',7):  return 1;
    case RP('F',5):  return 2;
    case RP('D',11): return 3;
    case RP('F',0):  return 4;
    case RP('B',1):  return 5;
    case RP('E',5):  return 6;
    case RP('C',13): return 7;
    case RP('B',3):  return 8;
    case RP('C',4):  return 10;
    case RP('D',15): return 11;
    case RP('G',0):  return 12;
    case RP('A',15): return 13;
    case RP('D',7):  return 14;
    }
    syslog(LOG_ERR, "gpio: cannot map peripheral input pin %c%d, group 2",
        pin_name[pin>>4], pin & 15);
    return -1;
}

int gpio_input_map3(int pin)
{
    switch (pin) {
    case RP('D',9):  return 0;
    case RP('G',6):  return 1;
    case RP('B',8):  return 2;
    case RP('B',15): return 3;
    case RP('D',4):  return 4;
    case RP('B',0):  return 5;
    case RP('E',3):  return 6;
    case RP('B',7):  return 7;
    case RP('F',12): return 9;
    case RP('D',12): return 10;
    case RP('F',8):  return 11;
    case RP('C',3):  return 12;
    case RP('E',9):  return 13;
    }
    syslog(LOG_ERR, "gpio: cannot map peripheral input pin %c%d, group 3",
        pin_name[pin>>4], pin & 15);
    return -1;
}

int gpio_input_map4(int pin)
{
    switch (pin) {
    case RP('D',1):  return 0;
    case RP('G',9):  return 1;
    case RP('B',14): return 2;
    case RP('D',0):  return 3;
    case RP('B',6):  return 5;
    case RP('D',5):  return 6;
    case RP('B',2):  return 7;
    case RP('F',3):  return 8;
    case RP('F',13): return 9;
    case RP('F',2):  return 11;
    case RP('C',2):  return 12;
    case RP('E',8):  return 13;
    }
    syslog(LOG_ERR, "gpio: cannot map peripheral input pin %c%d, group 4",
        pin_name[pin>>4], pin & 15);
    return -1;
}

int gpio_is_analog_port(int pin) {
    switch (pin) {
        case RP('B',0):
        case RP('B',1):
        case RP('B',2):
        case RP('B',3):
        case RP('B',4):
        case RP('B',5):
        case RP('B',6):
        case RP('B',7):
        case RP('B',8):
        case RP('B',9):
        case RP('B',10):
        case RP('B',11):
        case RP('B',12):
        case RP('B',13):
        case RP('B',14):
        case RP('B',15):
        case RP('G',6):
        case RP('G',7):
        case RP('G',8):
        case RP('G',9):
        case RP('E',4):
        case RP('E',5):
        case RP('E',6):
        case RP('E',7):
            return 1;
    }

    return 0;
}

int gpio_port_has_analog(int port) {
    return ((port == 1) || (port == 4) || (port == 6));
}

void gpio_enable_pull_up(int pin) {
    PULLUSET(PORB(pin)) = (1 << PINB(pin));
}

void gpio_disable_pull_up(int pin) {
    PULLUCLR(PORB(pin)) = (1 << PINB(pin));    
}

void gpio_disable_analog(int pin) {
    if (gpio_is_analog_port(pin)) {
        gpio_disable_pull_up(pin);

        ANSELCLR(PORB(pin)) = (1 << PINB(pin));
    }
}

void gpio_enable_analog(int pin) {
    if (gpio_is_analog_port(pin)) {
        ANSELSET(PORB(pin)) = (1 << PINB(pin));
        gpio_pin_input(pin);
        gpio_disable_pull_up(pin);
    }
}

char gpio_portname(int pin) {
    return pin_name[(pin >> 4) & 15];
}

int gpio_pinno(int pin) {
    return pin & 15;
}
