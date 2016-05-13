/*
 * Whitecat, I2C driver
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

#include <unistd.h>
#include <syslog.h>
#include <drivers/error.h>
#include <drivers/cpu/resource.h>
#include <drivers/i2c/i2c.h>
#include <machine/pic32mz.h>

tdriver_error *i2c_setup(int unit, int speed) {
    int scl, sda;
    
    unit--;
    
    // TO DO
    // Lock resources used on sda and scl pins used
    
    switch (unit) {
        case 0: scl = (I2C1_PINS & 0xff00) >> 8;sda = (I2C1_PINS & 0x00ff);break;
        case 1: scl = (I2C2_PINS & 0xff00) >> 8;sda = (I2C2_PINS & 0x00ff);break;
        case 2: scl = (I2C3_PINS & 0xff00) >> 8;sda = (I2C3_PINS & 0x00ff);break;
        case 3: scl = (I2C4_PINS & 0xff00) >> 8;sda = (I2C4_PINS & 0x00ff);break;
        case 4: scl = (I2C5_PINS & 0xff00) >> 8;sda = (I2C5_PINS & 0x00ff);break;
    }

    // Enable I2C peripheripal
    PMD5CLR = (1 << (16 + unit));
    
    // Configure module
    *(&I2C1CON + unit * 0x200) = 0;    
        
    *(&I2C1CON + unit * 0x200) = (1 << 15) | // Turn on module
                                 (1 << 13) | // Stop on idle mode
                                 (1 << 9);   // Slew rate control disabled
            
    // Set BRG
    *(&I2C1BRG + unit * 0x200) = (unsigned int)(((((double)1.0/(((double)2.0) * ((double)speed))) - ((double)0.00000014)) * ((double)PBCLK2_HZ)) - ((double)2.0));

    syslog(LOG_INFO,
        "i2c%u at pins scl=%c%d/sdc=%c%d", unit + 1,
        gpio_portname(scl), gpio_pinno(scl),
        gpio_portname(sda), gpio_pinno(sda)
    );

    return NULL;
}

void i2c_start(int unit) {    
    unit--;
    
    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Set start condition
    *(&I2C1CONSET + unit * 0x200) = (1 << 0);
    
    // Waiting for done
    while (*(&I2C1CON + unit * 0x200) & (1 << 0));      
}

void i2c_stop(int unit) {
    unit--;
    
    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Set stop condition
    *(&I2C1CONSET + unit * 0x200) = (1 << 2);

    // Waiting for done
    while (*(&I2C1CON + unit * 0x200) & (1 << 2));
}

void i2c_send_ack(int unit) {
    unit--;
    
    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Enable ACK
    *(&I2C1CONSET + unit * 0x200) = (1 << 4);
    
    // Waiting for done
    while (*(&I2C1CON + unit * 0x200) & (1 << 4));   
}

void i2c_send_nack(int unit) {
    unit--;
    
    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Enable NACK
    *(&I2C1CONSET + unit * 0x200) = (1 << 5);
    
    // Waiting for done
    while (*(&I2C1CON + unit * 0x200) & (1 << 5));    
}

int i2c_send_address_write(int unit, char address) {
    unit--;

    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    
    
    // Send address to slave with a write indication
    *(&I2C1TRN + unit * 0x200) = (address << 1);

    // Waiting for done
    while (*(&I2C1STAT + unit * 0x200) & (1 << 0));

    // Return 1 if ACK
    return !(*(&I2C1STAT + unit * 0x200) & (1 << 15));
}

int i2c_send_address_read(int unit, char address) {
    unit--;
    
    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Send address to slave with a read indication
    *(&I2C1TRN + unit * 0x200) = (address << 1) | 0x01;

    // Waiting for done
    while (*(&I2C1STAT + unit * 0x200) & (1 << 0));
 
    // Return 1 if ACK
    return !(*(&I2C1STAT + unit * 0x200) & (1 << 15));
}

void i2c_read(int unit, char *data) {
    unit--;
    
    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Enable receive
    *(&I2C1CONSET + unit * 0x200) = (1 << 3);

    // Waiting for done
    while (*(&I2C1CON + unit * 0x200) & (1 << 3));    
    
    // Waiting for data
    while (!(*(&I2C1STAT + unit * 0x200) & (1 << 1)));    

    *data = (char)(*(&I2C1RCV + unit * 0x200) & 0x00ff);  
    
    // Send ACK
    i2c_send_ack(1);
}

int i2c_write(int unit, char data) {
    unit--;

    // Wait for bus inactive
    while ((*(&I2C1CON + unit * 0x200) & (0b11111)) || (*(&I2C1STAT + unit * 0x200) & (0b100000000000000)));    

    // Send address to slave with a read indication
    *(&I2C1TRN + unit * 0x200) = data;

    // Waiting for done
    while (*(&I2C1STAT + unit * 0x200) & (1 << 0));
    
    // Return 1 if ACK
    return !(*(&I2C1STAT + unit * 0x200) & (1 << 15));
}