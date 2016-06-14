/*
 * Whitecat, Lora WAN driver for RN2483
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
#include <drivers/lora/lora.h>

#include <unistd.h>
#include <syslog.h>
#include <drivers/cpu/resource.h>
#include <drivers/uart/uart.h>

#if USE_LORA

// Setup driver
tdriver_error *lora_setup() {
    char resp[255];

    // TO DO: check resources
    
    // Init the UART where RN2483 is attached
    uart_init(LORA_UART, LORA_UART_BR, PIC32_UMODE_PDSEL_8NPAR, LORA_UART_BUFF_SIZE);
    uart_init_interrupts(LORA_UART);
    
    // Factory reset
    uart_send_command(LORA_UART, "sys reset", 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 5000)) {
        syslog(LOG_INFO, "RN2483 not found on %s", uart_name(LORA_UART));

        // TO DO: timeout
        return NULL;
    }
    
    if (!strstr(resp,"RN2483")) {
        syslog(LOG_INFO, "RN2483 not found on %s", uart_name(LORA_UART));
        
        // TO DO: not find RN2483
        return NULL;        
    }

    syslog(LOG_INFO, "RN2483 is on %s", uart_name(LORA_UART));
    
    return NULL;
}

int lora_mac_set(const char *command, const char *value) {
    char buffer[255];
    char resp[255];
    
    sprintf(buffer, "mac set %s %s", command, value);

    if (!uart_send_command(LORA_UART, buffer, 1, resp, 0, 1000, 1, "ok")) {
        return 0;
    }  
    
    return 1;
}

char *lora_mac_get(const char *command) {
    char buffer[255];
    char resp[255];
    
    sprintf(buffer, "mac get %s", command);
    
    uart_send_command(LORA_UART, buffer, 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 1000)) {
        return NULL;
    }
    
    char *result = (char *)malloc(strlen(resp) + 1);
    strcpy(result, resp);
    
    return result;
}
#endif

