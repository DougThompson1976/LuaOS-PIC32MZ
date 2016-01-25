/*
 * Whitecat, GPS driver
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

#if USE_GPS

#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"
#include "event_groups.h"

#include <drivers/uart/uart.h>
#include <drivers/gps/gps.h>
#include <drivers/gps/nmea0183.h>
#include <drivers/sim908/sim908.h>

#include <stdlib.h>
#include <syslog.h>

static TaskHandle_t gpsTask_h = NULL;
static EventGroupHandle_t gpsEvent;
static int inited = 0;
static QueueHandle_t positions;

static void gps_init() {
    if (inited) return;
    
    gpsEvent = xEventGroupCreate();
    xEventGroupClearBits(gpsEvent, evGps_started | evGps_stopped | evGps_stop);
    
    positions = xQueueCreate(10, sizeof(struct position));
}

static void gpsTask(void *pvParameters) {
    QueueHandle_t  *q;         // GPS queue
    u8_t           *sentence;  // Received packet
    u8_t           *buffer;    // Current buffer position of received packet
    u8_t            byte;      // Received byte
    u32_t           bytes;     // Received bytes
    EventBits_t     uxBits;
    struct position new_pos;
    struct position first_pos;


    // Allocate space for sentence
    sentence = malloc(MAX_NMA_SIZE);
    buffer = sentence;

    // Get UART queue
    q = uart_get_queue(SIM908_UART_DBG);
    
    xEventGroupSetBits(gpsEvent, evGps_started); 
    
    for(;;) {
        uxBits = xEventGroupWaitBits(gpsEvent, evGps_stop, pdTRUE, pdFALSE, 0);
        if (uxBits & (evGps_stop)) {
            break;
        }
        
        if (xQueueReceive(q, &byte, (TickType_t)portTICK_PERIOD_MS) == pdTRUE) {
            // Byte is received, store in buffer
            *buffer++ = byte;
            bytes++;

            if ((byte == '\n') || (bytes == MAX_NMA_SIZE)) {
                // A sentence is received
                nmea_parse(sentence);
                
                buffer = sentence;
                bytes = 0;
                
                // Queue new position, if present
                if (nmea_new_pos()) {                                        
                    new_pos.lat  = nmea_lat();
                    new_pos.lon  = nmea_lon();
                    new_pos.sats = nmea_sats();
                    new_pos.when = time(NULL);
                    

                   if (xQueueSend(positions, &new_pos, 0) == errQUEUE_FULL) {
                       // Queue is full
                       // Free one element
                       xQueueReceive(positions, &first_pos, 0);
                       
                       // Queue again
                       xQueueSend(positions, &new_pos, 0);
                   }
                }
            }
        }
    }

    free(sentence);
    
    xEventGroupSetBits(gpsEvent, evGps_stopped);    
    
    vTaskDelete(NULL);
}

int gps_start() {
    sim908_err err;

    gps_init();
    
    err = sim908_init(0, 1);
    if (err == ERR_OK) {
        // Create task for gps process
        xTaskCreate(gpsTask, "gps", configMINIMAL_STACK_SIZE * 10, NULL, tskDEF_PRIORITY, &gpsTask_h);
        xEventGroupWaitBits(gpsEvent, evGps_started, pdTRUE, pdFALSE, portMAX_DELAY);

        syslog(LOG_INFO, "gps started");
    } else {
        syslog(LOG_ERR, "sim908 %s", sim908_error(err));        
    }

    return (err != ERR_OK);    
}

int gps_stop() {
    syslog(LOG_INFO, "gps stopping ...");
    
    xEventGroupSetBits(gpsEvent, evGps_stop);
    xEventGroupWaitBits(gpsEvent, evGps_stopped, pdTRUE, pdFALSE, portMAX_DELAY);

    sim908_stop(0, 1);
    
    syslog(LOG_INFO, "gps stopped");
    
    return 0;
}

int gps_get_pos(struct position *pos, int timeout) {
    if (timeout == portMAX_DELAY) {
        timeout = portMAX_DELAY;
    } else {
        timeout = portTICK_PERIOD_MS * timeout;
    }
    
    return (!xQueueReceive(positions, pos, timeout));
}

#endif
