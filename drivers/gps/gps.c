/*
 * Whitecat, GPS driver
 *
 * Copyright (C) 2015
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.com)
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
#include "FreeRTOS.h"

#include <stdlib.h>

#include "queue.h"
#include "drivers/gps/nmea0183.h"
#include "drivers/uart/uart.h"

#if USE_GPS

void gpsTask(void *pvParameters) {
    QueueHandle_t *q;        // GPS queue
    u8_t          *sentence; // Received packet
    u8_t          *buffer;   // Current buffer position of received packet
    u8_t           byte;     // Received byte
    u32_t          bytes;    // Received bytes

    // Allocate space for sentence
    sentence = malloc(MAX_NMA_SIZE);
    buffer = sentence;

    // Get UART queue
    q = uart_get_queue(SIM908_UART_DBG);
    
    for(;;) {
        if (xQueueReceive(q, &byte, (TickType_t)portTICK_PERIOD_MS) == pdTRUE) {
            // Byte is received, store in buffer
            *buffer++ = byte;
            bytes++;

            if ((byte == '\n') || (bytes == MAX_NMA_SIZE)) {
                // A sentence is received
                nmea_parse(sentence);
                
                buffer = sentence;
                bytes = 0;
            }
        }
    }

    vTaskDelete(NULL);
}

#endif
