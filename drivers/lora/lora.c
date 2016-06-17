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
    //uart_debug(LORA_UART, 1);
    
    uart_consume(LORA_UART);

    // System reset
    uart_send_command(LORA_UART, "sys reset", 0, 1,  NULL, 0, 0, 0);    
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

    if (!uart_send_command(LORA_UART, buffer, 0, 1, resp, 0, 1000, 1, "ok")) {
        return 0;
    }  
    
    return 1;
}

char *lora_mac_get(const char *command) {
    char buffer[255];
    char resp[255];
    
    sprintf(buffer, "mac get %s", command);
    
    uart_send_command(LORA_UART, buffer, 0, 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 1000)) {
        return NULL;
    }
    
    char *result = (char *)malloc(strlen(resp) + 1);
    strcpy(result, resp);
    
    return result;
}

int lora_error(char *resp) {
    if (strcmp(resp, "keys_not_init") == 0) {    
        return LORA_KEYS_NOT_CONFIGURED;
    } else if (strcmp(resp, "no_free_ch") == 0) {
        return LORA_ALL_CHANNELS_BUSY;
    } else if (strcmp(resp, "silent") == 0) {
        return LORA_DEVICE_IN_SILENT_STATE;
    } else if (strcmp(resp, "busy") == 0) {
        return LORA_DEVICE_DEVICE_IS_NOT_IDLE;
    } else if (strcmp(resp, "mac_paused") == 0) {
        return LORA_PAUSED;
    } else if (strcmp(resp, "not_joined") == 0) {
        return LORA_NOT_JOINED;
    } else if (strcmp(resp, "frame_counter_err_rejoin_needed") == 0) {
        return LORA_REJOIN_NEEDED;
    } else if (strcmp(resp, "invalid_data_len") == 0) {
        return LORA_INVALID_DATA_LEN;
    } 
}

int lora_join_otaa() {
    char resp[255];
    
    uart_send_command(LORA_UART, "mac join otaa", 0, 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 1000)) {
        return LORA_TIMEOUT;
    }
    
    if (strcmp(resp, "ok") != 0) {
        return lora_error(resp);
    }
    
    if (!uart_reads(LORA_UART, resp, 1, 10000)) {
        return LORA_TIMEOUT;
    }    

    if (strcmp(resp, "denied") == 0) {
        return LORA_JOIN_DENIED;
    } else if (strcmp(resp, "accepted") == 0) {
        return 1;
    } else {
        return LORA_UNEXPECTED_RESPONSE;
    }
}

int lora_tx(int cnf, int port, const char *data) {
    char buffer[255];
    char resp[255];
    
    if (cnf) {
        sprintf(buffer,"mac tx cnf %d %s", port, data);
    } else {
        sprintf(buffer,"mac tx uncnf %d %s", port, data);        
    }
    
    uart_send_command(LORA_UART, buffer, 0, 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 1000)) {
        return LORA_TIMEOUT;
    }
    
    if (strcmp(resp, "ok") != 0) {
        return lora_error(resp);
    }
    
    if (!uart_reads(LORA_UART, resp, 1, 10000)) {
        return LORA_TIMEOUT;
    }    

    if (strcmp(resp, "mac   _tx_ok") == 0) {
        return 1;
    } else if (strcmp(resp, "mac_err") == 0) {
    } else {
    }
}

#endif

