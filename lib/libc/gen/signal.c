/*
 * Whitecat, minimal signal implementation
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

#include "FreeRTOS.h"
#include "task.h"

#include <unistd.h>
#include <signal.h>
#include <pthread.h>

QueueHandle_t signal_q;

void signalTask(void *pvParameters) {
    int s;
    
    while (1) {
         if (xQueueReceive(signal_q, &s, portMAX_DELAY) == pdTRUE) {
             _pthread_queue_signal(s);
         }
    }
}

void _signal_init() {
    // Create signal queue
    signal_q = xQueueCreate(10, sizeof(int));
    
    // Create signal task dispatcher
    xTaskCreate(signalTask, "signal", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, NULL);
}

sig_t signal(int s, sig_t h) {
    return _pthread_signal(s, h);
}