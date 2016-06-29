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
#include "FreeRTOS.h"
#include "task.h"
#include "event_groups.h"
        
#include <unistd.h>
#include <syslog.h>
#include <sys/mutex.h>
#include <drivers/cpu/resource.h>
#include <drivers/uart/uart.h>
#include <drivers/lora/lora.h>
#include <drivers/gpio/gpio.h>

#if USE_LORA

#define LORA_TIMER_FREQ portTICK_PERIOD_MS * 5000
#define LORA_WAIT_ENTER_COMMAND portTICK_PERIOD_MS * 200

// Definition of Lora events used by this driver
#define evLora_ok                                 (1 <<  0)
#define evLora_join_accepted                      (1 <<  1)
#define evLora_join_denied                        (1 <<  2)
#define evLora_keys_not_configured                (1 <<  3)
#define evLora_all_channels_busy                  (1 <<  4)
#define evLora_device_in_silent_state             (1 <<  5)
#define evLora_device_is_not_idle                 (1 <<  6)
#define evLora_paused                             (1 <<  7)
#define evLora_not_joined                         (1 <<  8)
#define evLora_rejoin_needed                      (1 <<  9)
#define evLora_invalid_data_len                   (1 << 10)
#define evLora_transmission_fail_ack_not_received (1 << 11)
#define evLora_tx_ok                              (1 << 12)
#define evLora_invalid_param                      (1 << 13)

#define loraEvent_ALL_EVENTS 0b1111111111111

// Expected events after enter of set command
#define evLoraSetEnterCommand  \
    (evLora_ok)

// Expected events after enter of join command
#define evLoraJoinEnterCommand  \
    (evLora_ok | evLora_keys_not_configured | evLora_all_channels_busy | \
     evLora_device_in_silent_state | evLora_all_channels_busy | \
     evLora_paused)

// Expected events after end of join command
#define evLoraJoinEndCommand  \
    (evLora_join_accepted | evLora_join_denied)

// Expected events after enter of tx command
#define evLoraTxEnterCommand  \
    (evLora_ok | evLora_not_joined | evLora_all_channels_busy | \
     evLora_device_in_silent_state | evLora_rejoin_needed | \
     evLora_device_is_not_idle | evLora_paused | evLora_invalid_data_len)

// Expected events after end of tx command
#define evLoraTxEndCommand  \
    (evLora_tx_ok | evLora_transmission_fail_ack_not_received | \
     evLora_invalid_data_len)

// Group handle for lora envents
static EventGroupHandle_t loraEvent;

// Tasks handle for Lora
static TaskHandle_t loraRXHandle = NULL;

// Timer handle for Lora
static TimerHandle_t loraTimer = NULL;

static int joined = 0; // Are joined?
static int otaa = 0;   // Las join were by OTAA?
static int setup = 0;  // Driver is setup?

// Callback function to call when data is received
static lora_rx *lora_rx_callback = NULL;

// Mutext for lora 
static struct mtx lora_mtx;

void _lora_init() {
    // Create lora mutex
    mtx_init(&lora_mtx, NULL, NULL, 0);

    // Create an event group for handle events for this driver
    loraEvent = xEventGroupCreate();
}

// This function parses a string received over the UART, and transform it into
// a token
static int lora_parse_response(char *resp) {
    if (strcmp(resp, "ok") == 0) {
        return LORA_OK;
    } else if (strcmp(resp, "accepted") == 0) {    
        return LORA_JOIN_ACCEPTED;
    } else if (strcmp(resp, "denied") == 0) {    
        return LORA_JOIN_DENIED;
    } else if (strcmp(resp, "mac_tx_ok") == 0) {    
        return LORA_TX_OK;
    } else if (strncmp(resp, "mac_rx", 6) == 0) {    
        return LORA_RX_OK;
    } else if (strcmp(resp, "keys_not_init") == 0) {    
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
    } else if (strcmp(resp, "mac_err") == 0) {
        return LORA_TRANSMISSION_FAIL_ACK_NOT_RECEIVED;
    } else if (strcmp(resp, "invalid_param") == 0) {
        return LORA_INVALID_PARAM;
    }
}

// Translate a lora event to an error code
static int lora_error(EventBits_t uxBits) {
    if (uxBits & evLora_join_denied) {
        return LORA_JOIN_DENIED;
    } else if (uxBits & evLora_keys_not_configured) {
        return LORA_KEYS_NOT_CONFIGURED;        
    } else if (uxBits & evLora_all_channels_busy) {
        return LORA_ALL_CHANNELS_BUSY;        
    } else if (uxBits & evLora_device_in_silent_state) {
        return LORA_DEVICE_IN_SILENT_STATE;        
    } else if (uxBits & evLora_device_is_not_idle) {
        return LORA_DEVICE_DEVICE_IS_NOT_IDLE;        
    } else if (uxBits & evLora_paused) {
        return LORA_PAUSED;        
    } else if (uxBits & evLora_rejoin_needed) {
        return LORA_NOT_JOINED;        
    } else if (uxBits & evLora_rejoin_needed) {
        return LORA_REJOIN_NEEDED;        
    } else if (uxBits & evLora_invalid_data_len) {
        return LORA_INVALID_DATA_LEN;        
    } else if (uxBits & evLora_transmission_fail_ack_not_received) {
        return LORA_TRANSMISSION_FAIL_ACK_NOT_RECEIVED;        
    } else if (uxBits & evLora_invalid_param) {
        return LORA_INVALID_PARAM;        
    } else {
        return LORA_UNEXPECTED_RESPONSE;
    }
}

// This task scans for any new line received over the UART, and takes the
// corresponding action
static void loraRX(void *pvParameters) {
    char buffer[255];
    char payload[255];
    char *payload_copy;
    int  payload_len;
    
    int resp;
    int port;
    
    UNUSED_ARG(pvParameters);
    
    for(;;) {
        if (uart_reads(LORA_UART, buffer, 1, portMAX_DELAY)) {
            xEventGroupClearBits(loraEvent,loraEvent_ALL_EVENTS);
            
            resp = lora_parse_response(buffer);
            switch (resp) {
                case LORA_OK:
                    xEventGroupSetBits(loraEvent, evLora_ok); break;
                case LORA_INVALID_PARAM:
                    xEventGroupSetBits(loraEvent, evLora_invalid_param); break;
                case LORA_JOIN_DENIED:
                    xEventGroupSetBits(loraEvent, evLora_join_denied); break;
                case LORA_JOIN_ACCEPTED:
                    xEventGroupSetBits(loraEvent, evLora_join_accepted); break;
                case LORA_KEYS_NOT_CONFIGURED:
                    xEventGroupSetBits(loraEvent, evLora_keys_not_configured); break;
                case LORA_ALL_CHANNELS_BUSY:
                    xEventGroupSetBits(loraEvent, evLora_all_channels_busy); break;
                case LORA_DEVICE_IN_SILENT_STATE:
                    xEventGroupSetBits(loraEvent, evLora_device_in_silent_state); break;
                case LORA_DEVICE_DEVICE_IS_NOT_IDLE:
                    xEventGroupSetBits(loraEvent, evLora_device_is_not_idle); break;
                case LORA_PAUSED:
                    xEventGroupSetBits(loraEvent, evLora_paused); break;
                case LORA_NOT_JOINED:
                    xEventGroupSetBits(loraEvent, evLora_not_joined); break;
                case LORA_REJOIN_NEEDED:
                    xEventGroupSetBits(loraEvent, evLora_rejoin_needed); break;
                case LORA_INVALID_DATA_LEN:
                    xEventGroupSetBits(loraEvent, evLora_invalid_data_len); break;
                case LORA_TRANSMISSION_FAIL_ACK_NOT_RECEIVED:
                    xEventGroupSetBits(loraEvent, evLora_transmission_fail_ack_not_received); break;
                case LORA_TX_OK:
                    xEventGroupSetBits(loraEvent, evLora_tx_ok); break;
                case LORA_RX_OK:
                    // Something received
                    
                    // Get received port / payload
                    payload[0] = 0x00;
                    sscanf(buffer,"mac_rx %d %s", &port, payload);

                    payload_len = strlen(payload);
                    if (payload_len) {
                        if (lora_rx_callback) {
                            // Make a copy of the payload
                            payload_copy = (char *)malloc(payload_len + 1);
                            if (payload_copy) {
                                strcpy(payload_copy, payload);
                                
                                lora_rx_callback(port, payload_copy);
                            }                            
                        }
                    }
                    
                    xEventGroupSetBits(loraEvent, evLora_tx_ok); break;
            }
        }    
    }
}

void lora_timer(void *arg) {
    EventBits_t uxBits;
    
    UNUSED_ARG(arg);
  
    mtx_lock(&lora_mtx);
    if (joined) {
        uart_send_command(LORA_UART, "mac tx uncnf 1 01", 0, 1,  NULL, 0, 0, 0);    
    }
    mtx_unlock(&lora_mtx);
}

static void lora_hw_reset() {
    gpio_pin_clr(LORA_RST);
    delay(500);
    gpio_pin_set(LORA_RST);
    delay(500);   
}

// Setup driver
tdriver_error *lora_setup() {
    char resp[255];
    int retries = 0;

    if (setup) return NULL;
        
    // TO DO: check resources
    
    // Make a hardware reset
    gpio_disable_analog(LORA_RST);
    gpio_pin_output(LORA_RST);
    gpio_pin_set(LORA_RST);
    
    // Init the UART where RN2483 is attached
    uart_init(LORA_UART, LORA_UART_BR, PIC32_UMODE_PDSEL_8NPAR, LORA_UART_BUFF_SIZE);
    uart_init_interrupts(LORA_UART);
    //uart_debug(LORA_UART, 1);
    
  retry:
    uart_consume(LORA_UART);

    // System reset
    uart_send_command(LORA_UART, "sys reset", 0, 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 500)) {
        if (retries < 5) {
            retries++;
            lora_hw_reset();
            goto retry;
        }
        
        syslog(LOG_INFO, "RN2483 not found on %s", uart_name(LORA_UART));

        return setup_error(LORA, "RN2483 not found");
    }
    
    if (!strstr(resp,"RN2483")) {
        syslog(LOG_INFO, "RN2483 not found on %s", uart_name(LORA_UART));
        
        return setup_error(LORA, "RN2483 not found");
    }

    syslog(LOG_INFO, "RN2483 is on %s", uart_name(LORA_UART));
    
    // Create a task for inspect UART trafic
    xTaskCreate(loraRX, "loraTask", netTaskStack, NULL, tskIDLE_PRIORITY, &loraRXHandle);
    
    loraTimer = xTimerCreate("loraTimer", LORA_TIMER_FREQ, pdTRUE, (void *) 0, lora_timer);
    if(loraTimer != NULL ){
        xTimerStart(loraTimer, 0);
    }
        
    setup = 1;
    
    return NULL;
}

int lora_mac_set(const char *command, const char *value) {
    EventBits_t uxBits;
    char buffer[255];

    sprintf(buffer, "mac set %s %s", command, value);

    mtx_lock(&lora_mtx);

    if (!setup) {
        mtx_unlock(&lora_mtx);
        return LORA_NOT_SETUP;
    }

    uart_send_command(LORA_UART, buffer, 0, 1,  NULL, 0, 0, 0);    
    
    uxBits = xEventGroupWaitBits(loraEvent, evLoraSetEnterCommand,pdTRUE, pdFALSE, LORA_WAIT_ENTER_COMMAND);
    if (uxBits & (evLora_ok)) {
        mtx_unlock(&lora_mtx);

        return LORA_OK;
    }

    mtx_unlock(&lora_mtx);

    return lora_error(uxBits);
}

char *lora_mac_get(const char *command) {
    char buffer[255];
    char resp[255];
    
    sprintf(buffer, "mac get %s", command);
    
    mtx_lock(&lora_mtx);

    uart_send_command(LORA_UART, buffer, 0, 1,  NULL, 0, 0, 0);    
    if (!uart_reads(LORA_UART, resp, 1, 1000)) {
        return NULL;
    }
    
    char *result = (char *)malloc(strlen(resp) + 1);
    strcpy(result, resp);
    
    mtx_unlock(&lora_mtx);

    return result;
}

int lora_join_otaa() {
    EventBits_t uxBits;
    
    joined = 0;
    otaa = 1;
    
    mtx_lock(&lora_mtx);

    if (!setup) {
        mtx_unlock(&lora_mtx);
        return LORA_NOT_SETUP;
    }

    uart_send_command(LORA_UART, "mac join otaa", 0, 1,  NULL, 0, 0, 0);    
    uxBits = xEventGroupWaitBits(loraEvent, evLoraJoinEnterCommand,pdTRUE, pdFALSE, LORA_WAIT_ENTER_COMMAND);
    if (!(uxBits & (evLora_ok))) {   
        mtx_unlock(&lora_mtx);

        return lora_error(uxBits);
    }

    uxBits = xEventGroupWaitBits(loraEvent, evLoraJoinEndCommand,pdTRUE, pdFALSE, portTICK_PERIOD_MS * 20000);
    if (uxBits & (evLora_join_accepted)) {
        joined = 1;
        mtx_unlock(&lora_mtx);

        return LORA_OK;
    }
    
    if (uxBits & (evLora_join_denied)) {
        mtx_unlock(&lora_mtx);

        return LORA_JOIN_DENIED;
    }
    
    mtx_unlock(&lora_mtx);
    return lora_error(uxBits);
}

int lora_tx(int cnf, int port, const char *data) {
    EventBits_t uxBits;
    char buffer[255];
    
    if (cnf) {
        sprintf(buffer,"mac tx cnf %d %s", port, data);
    } else {
        sprintf(buffer,"mac tx uncnf %d %s", port, data);        
    }

    mtx_lock(&lora_mtx);

    if (!setup) {
        mtx_unlock(&lora_mtx);
        return LORA_NOT_SETUP;
    }

    uart_send_command(LORA_UART, buffer, 0, 1,  NULL, 0, 0, 0);    
    uxBits = xEventGroupWaitBits(loraEvent, evLoraTxEnterCommand,pdTRUE, pdFALSE, LORA_WAIT_ENTER_COMMAND);
    if (!(uxBits & (evLora_ok))) {  
        mtx_unlock(&lora_mtx);
        return lora_error(uxBits);
    }

    uxBits = xEventGroupWaitBits(loraEvent, evLoraTxEndCommand,pdTRUE, pdFALSE, portTICK_PERIOD_MS * 10000);
    if (uxBits & (evLora_tx_ok)) {
        mtx_unlock(&lora_mtx);
        return LORA_OK;
    }
    
    mtx_unlock(&lora_mtx);
    
    return lora_error(uxBits);
}

void lora_set_rx_callback(lora_rx *callback) {
    lora_rx_callback = callback;
}
#endif

