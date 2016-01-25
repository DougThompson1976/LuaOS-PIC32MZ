/*
 * Whitecat, GPRS serial driver for PPP
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
#include "queue.h"
#include "task.h"
#include "timers.h"
#include "event_groups.h"

#include "drivers/gpio/gpio.h"
#include "drivers/network/network.h"
#include "drivers/uart/uart.h"
#include "drivers/sim908/sim908.h"
#include "utils/delay.h"
#include "drivers/gps/nmea0183.h"
#include "drivers/gprs/gprs.h"

#include "drivers/gps/gps.h"
#include "netif/ppp/ppp.h"
#include "netif/ppp/pppos.h"
#include "netif/ppp/ppp_impl.h"
#include "lwip/sio.h"
#include "lwip/sockets.h"
#include "lwip/inet.h"

#include <syslog.h>
#include <sys/mutex.h>

#define SIM908_DEBUG 0

// Driver flags
#define SIM908_FLAG_INITED       (1 << 0)
#define SIM908_FLAG_NEED_FUNC    (1 << 1)
#define SIM908_FLAG_NEED_PIN     (1 << 2)
#define SIM908_FLAG_NEED_PUK     (1 << 3)
#define SIM908_FLAG_NEED_SIM     (1 << 4)
#define SIM908_FLAG_GPRS_STARTED (1 << 5)
#define SIM908_FLAG_GPS_STARTED  (1 << 6)

static unsigned int flags = 0;

// Driver evets
#define sim908_ppp_started       (1 << 0)
#define sim908_ppp_stopped       (1 << 1)
#define sim908_ppp_stop          (1 << 2)
#define sim908_ppp_pause         (1 << 3)
#define sim908_ppp_paused        (1 << 4)
#define sim908_ppp_resume        (1 << 5)
#define sim908_ppp_resumed       (1 << 6)

static struct mtx sio_mtx;

u32_t sio_write(sio_fd_t fd, u8_t *data, u32_t len) {
    UNUSED_ARG(fd);

    u32_t sended = 0;

    if (len <= 0) return 0;

    mtx_lock(&sio_mtx);

    while (sended < len) {
        uart_write(SIM908_UART, *data++);
        sended++;
    }

    mtx_unlock(&sio_mtx);

    return sended;
}

#if USE_GPRS | USE_GPS

static EventGroupHandle_t sim908Event;
static EventBits_t uxBits;
static int ping;

#if USE_GPRS
static TaskHandle_t pppTask_h = NULL;

#define PPPOS_RX_BUFSIZE (PPP_MRU + PPP_HDRLEN)

// Other variables
extern struct netif gprs_netif;
static ppp_pcb *ppp;               // PPP connection

static time_t no_ip_start = 0;
static time_t last_ping = 0;

extern unsigned int activity;

// PPP link status call back, invoked by lwip when something related to PPP
// changes
static void linkStatusCB(ppp_pcb *ppp, int err_code, void *ctx) {
    UNUSED_ARG(ppp);
    UNUSED_ARG(ctx);

    switch(err_code) {
        case PPPERR_NONE:
            xEventGroupSetBits(networkEvent, evGprs_link_up | evGprs_started);
            syslog(LOG_INFO, "sim908 gprs ppp session up");
            break;

        case PPPERR_PARAM:
            xEventGroupSetBits(networkEvent, evGprs_link_down);
            syslog(LOG_ERR, "sim908 gprs ppp invalid parameter");
            break;

        case PPPERR_OPEN:
            xEventGroupSetBits(networkEvent, evGprs_link_down);
            syslog(LOG_ERR, "sim908 gprs ppp unable to open session");
            break;

        case PPPERR_USER:
            xEventGroupSetBits(networkEvent, evGprs_link_down);
            syslog(LOG_ERR, "sim908 gprs ppp user interrupted session");
            break;

        case PPPERR_CONNECT:
            xEventGroupSetBits(networkEvent, evGprs_link_down | evGprs_restart);
            syslog(LOG_ERR, "sim908 gprs ppp connection lost");
            break;

        case PPPERR_AUTHFAIL:
            xEventGroupSetBits(networkEvent, evGprs_link_down);
            syslog(LOG_ERR, "sim908 gprs ppp auth fail");
            break;

        case PPPERR_PROTOCOL:
            xEventGroupSetBits(networkEvent, evGprs_link_down);
            syslog(LOG_ERR, "sim908 gprs ppp failed to meet protocol");
            break;

        default:
            syslog(LOG_ERR, "sim908 gprs ppp unknow error (code %d)\n", err_code);
    }    
}

// Pause ppp task
static void ppp_pause() {
    syslog(LOG_INFO, "sim908 pausing ppp");    
    xEventGroupSetBits(sim908Event, sim908_ppp_pause); 
    xEventGroupWaitBits(sim908Event, sim908_ppp_paused, pdTRUE, pdFALSE, portMAX_DELAY);
    syslog(LOG_INFO, "sim908 ppp paused");
}

// Resume ppp task
static void ppp_resume() {
    syslog(LOG_INFO, "sim908 resuming ppp");    
    xEventGroupSetBits(sim908Event, sim908_ppp_resume); 
    xEventGroupWaitBits(sim908Event, sim908_ppp_resumed, pdTRUE, pdFALSE, portMAX_DELAY);
    syslog(LOG_INFO, "sim908 ppp resumed");
}

// Stop ppp task
static void ppp_stop() {
    syslog(LOG_INFO, "sim908 stopping ppp");    
    xEventGroupSetBits(sim908Event, sim908_ppp_stop);        
    xEventGroupWaitBits(sim908Event, sim908_ppp_stopped, pdTRUE, pdFALSE, portMAX_DELAY);
    syslog(LOG_INFO, "sim908 ppp stopped");
}

#endif

const char *sim908_error(int code) {
    switch (code) {
        case ERR_CANT_CONNECT: return "can't connect";break;
        case ERR_NO_CARRIER: return "no carrier";break;
        case ERR_CANT_SET_APN: return "can't set apn";break;
        case ERR_NOT_DETECTED: return "not detected";break;
        case ERR_INIT: return "init error";break;
        case ERR_PIN: return "PIN error";break;
        case ERR_POWEROFF: return "power-off error";break;
    }
}

static void sim908_watchdog() {
    if (gprs_netif.ip_addr.addr == 0) {
        // Has not ip
        if (!no_ip_start) {
            no_ip_start = time(NULL);
        }

        if (time(NULL) - no_ip_start >= 20) {
            no_ip_start = 0;
            xEventGroupSetBits(networkEvent, evGprs_link_down | evGprs_restart);
        }
    } else {
        // Has ip
        no_ip_start = 0;
        
/*
        if (!last_ping ) {
            last_ping = time(NULL);
        }
        
        if (time(NULL) - last_ping > 20) {
            // Test for connection
            ip_addr_t ping_target;

            ping_target.addr = DNS1;
            if (ping_send(ping, &ping_target) == ERR_OK) {
                ping_recv(ping);
            } else {
                xEventGroupSetBits(networkEvent, evGprs_link_down | evGprs_restart);
            }
            
            last_ping = time(NULL);
        }
*/
    }    
}

// Once sim908 is reset module does a reboot, until GPS ready us received module
// informs us of some events necessary for the module setup, such as: need for
// pin, presence of SIM, etc ... We detect this needed things in this function.
static sim908_err sim908_wait_for_initial_events() {
    int start, twait, timeout;
    char temp_buffer[20];

    timeout = 10000;
    twait = (CPU_HZ / 2000) * timeout;
    start = ReadCoreTimer();

    flags &= ~SIM908_FLAG_NEED_FUNC;
    flags &= ~SIM908_FLAG_NEED_PIN;
    flags &= ~SIM908_FLAG_NEED_PUK;
    flags &= ~SIM908_FLAG_NEED_SIM;

    while ((ReadCoreTimer() - start <= twait)) {
        if (uart_reads(SIM908_UART, temp_buffer, 1, 1000)) {
            if (strlen(temp_buffer) > 0) {
                if (strcmp(temp_buffer, "GPS Ready") == 0) {
                    return ERR_OK;
                } else if ((strcmp(temp_buffer, "+CFUN: 0") == 0) ||
                            (strcmp(temp_buffer, "+CFUN: 4") == 0)) {
                    // Minimum functionallity / transmit receive circuits 
                    // disabled
                    flags |= SIM908_FLAG_NEED_FUNC;
                    syslog(LOG_INFO,"sim908 need functionallity");                 
                } else if (strcmp(temp_buffer, "+CPIN: SIM PIN") == 0) {
                    // MT is waiting SIM PIN to be given
                    flags |= SIM908_FLAG_NEED_PIN;
                    syslog(LOG_INFO,"sim908 need pin");
                } else if (strcmp(temp_buffer, "+CPIN: SIM PUK") == 0) {
                    // MT is waiting SIM PUK to be given
                    flags |= SIM908_FLAG_NEED_PUK;
                    syslog(LOG_INFO,"sim908 need puk");
                } else if (strcmp(temp_buffer, "+CPIN: PH_SIM PIN") == 0) {
                    // ME is waiting for phone to SIM card
                    flags |= SIM908_FLAG_NEED_SIM;
                    syslog(LOG_INFO,"sim908 need sim");
                }
            }
        }
    }

    return ERR_INIT;
}

// SIM908 power on sequence
static sim908_err sim908_power_on() {
    int start, twait, timeout;
    uint8_t status = 0;

    // Status must be 0, if not exit
    status = gpio_pin_get(SIM908_STATUS_PIN);
    if (status == 1) {
        return ERR_OK;
    }
    
    // Power on GPRS
    gpio_pin_clr(SIM908_PWR_PIN);
    delay(1000);
    gpio_pin_set(SIM908_PWR_PIN);

    // Wait for available status
    timeout = 5000;
    twait = (CPU_HZ / 2000) * timeout;
    start = ReadCoreTimer();
    do {
        status = gpio_pin_get(SIM908_STATUS_PIN);
    } while ((status == 0) && (ReadCoreTimer() - start <= twait));

    if (status == 0) {
        return ERR_NOT_DETECTED;
    }

    // Wait for events, if GPRS and GPS are not started yet
    return sim908_wait_for_initial_events();
}
    
// SIM908 power off sequence
static sim908_err sim908_power_off() {
    int start, twait, timeout;
    uint8_t status = 0;

    // Status must be 1, if not exit
    status = gpio_pin_get(SIM908_STATUS_PIN);
    if (status == 0) {
        return ERR_OK;
    }
    
    // Power on GPRS
    gpio_pin_clr(SIM908_PWR_PIN);
    delay(1000);
    gpio_pin_set(SIM908_PWR_PIN);

    // Wait for unavailable status
    timeout = 10000;
    twait = (CPU_HZ / 2000) * timeout;
    start = ReadCoreTimer();
    do {
        status = gpio_pin_get(SIM908_STATUS_PIN);
    } while ((status == 1) && (ReadCoreTimer() - start <= twait));

    if (status == 1) {
        return ERR_NOT_DETECTED;
    }
    
    return ERR_OK;
}

static sim908_err sim908_set_pin() {
    char temp_buffer[20];

    strcpy(temp_buffer,"AT+CPIN=\"");
    strcat(temp_buffer,gprs_get_pin());
    strcat(temp_buffer,"\"");

    if (uart_send_command(SIM908_UART, temp_buffer, 1, NULL, 0, 1000, 1, "OK")) {
        flags &= ~SIM908_FLAG_NEED_PIN;

        // Wait for Call Ready
        if (!uart_wait_response(SIM908_UART, NULL, NULL, 0, 30000, 1, "Call Ready")) {
            return ERR_INIT;
        }
    } else {
        return ERR_PIN;
    }
    
    return ERR_OK;
}

static void sim908_enter_data_mode() {
    if (uart_send_command(SIM908_UART, "ATO", 1, NULL, 0, 1000, 1, "CONNECT")) {
        syslog(LOG_INFO, "sim908 is in data mode"); 
    }    
}

static void sim908_exit_data_mode() {
    int retries = 0;
        
    for(;;) {
        if (retries > 5) {
             syslog(LOG_ERR, "sim908 can't exit data mode"); 
             break;
        }
        
        usleep(1000000);
        uart_write(SIM908_UART,'+');
        uart_write(SIM908_UART,'+');
        uart_write(SIM908_UART,'+');
        usleep(500000);
        
        if (uart_wait_response(SIM908_UART, NULL, NULL, 0, 3000, 1, "OK")) {
            syslog(LOG_INFO, "sim908 is in command mode"); 
            break;
        }
        
        retries++;
    }
}

sim908_err sim908_init(int gprs, int gps) {
    uint8_t ok = 0;
    int retries = 0;

    // Init some required data structures and i/o pins once
    if (!(flags & SIM908_FLAG_INITED)) {
        sim908Event = xEventGroupCreate();
        xEventGroupClearBits(sim908Event, 0b111111111111111111111111);
        
        // Configure POWER and status pins
        gpio_disable_analog(SIM908_STATUS_PIN);

        gpio_pin_output(SIM908_PWR_PIN);
        gpio_pin_set(SIM908_PWR_PIN);
        gpio_pin_input(SIM908_STATUS_PIN);

        mtx_init(&sio_mtx, NULL, NULL, 0);

        flags |= SIM908_FLAG_INITED;
    }
   
    // Init UART's once
    // GPRS is controlled by 1 UART
    // GPRS is controlled by 2 UART
    #if USE_GPRS
        if (gprs && !(flags & SIM908_FLAG_GPRS_STARTED)) {
            syslog(LOG_INFO, "sim908 gprs is on %s", uart_name(SIM908_UART));

            uart_init(SIM908_UART, SIM908_BR, PIC32_UMODE_PDSEL_8NPAR, PPPOS_RX_BUFSIZE * 2);
            uart_debug(SIM908_UART, SIM908_DEBUG);
            uart_init_interrupts(SIM908_UART);
        }
    #endif

    #if USE_GPS
        if (gps && !(flags & SIM908_FLAG_GPS_STARTED)) {
            syslog(LOG_INFO, "sim908 gps is on %s and %s", 
                   uart_name(SIM908_UART), uart_name(SIM908_UART_DBG));            

            if (!(flags & SIM908_FLAG_GPRS_STARTED)) {
                uart_init(SIM908_UART, SIM908_BR, PIC32_UMODE_PDSEL_8NPAR, 256);                
                uart_debug(SIM908_UART, SIM908_DEBUG);
                uart_init_interrupts(SIM908_UART);
            }
            
            // GPS data are received from SIM908 debug UART
            uart_init(SIM908_UART_DBG, SIM908_BR, PIC32_UMODE_PDSEL_8NPAR, MAX_NMA_SIZE);
            uart_init_interrupts(SIM908_UART_DBG);
            uart_debug(SIM908_UART_DBG, SIM908_DEBUG);
        }
    #endif

    // Power on SIM908 only if GPS and GPRS are not started
    if (!(flags & (SIM908_FLAG_GPRS_STARTED | SIM908_FLAG_GPS_STARTED))) {
        if (gpio_pin_get(SIM908_STATUS_PIN) == 1) {
            syslog(LOG_INFO, "sim908 is powered-on");

            // SIM908 is power off. Do a power on sequence
            ok = sim908_power_off();
            if (ok == ERR_OK) {
                syslog(LOG_INFO, "sim908 is powered-off");
            } else {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ok));
                return ok;
            }

            // Power on
            ok = sim908_power_on();
            if (ok == ERR_OK) {
                syslog(LOG_INFO, "sim908 is powered-on");
            } else {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ok));
                return ok;
            }
        } else {
            syslog(LOG_INFO, "sim908 is powered-off");

            // SIM908 is power on, do a power off sequence for reset
            ok = sim908_power_on();
            if (ok == ERR_OK) {
                syslog(LOG_INFO, "sim908 is powered-on");
            } else {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ok));
                return ok;
            }
        }
        
        // Send AT command, and wait for an OK, so once received SIM908 is inited
        retries = 0;
        for(;;)  {
            ok = uart_send_command(SIM908_UART, "AT", 1, NULL, 0, 1000, 1, "OK");
            if (!ok) {
                retries++;
                if (retries > 20) {
                    syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_NOT_DETECTED));
                    return ERR_NOT_DETECTED;
                }
                delay(100);
            } else {
                syslog(LOG_INFO, "sim908 ready for accept AT commands");
                break;
            }
        }
    }

    // Now SIM908 is ready for GPRS and/or GPS
    
    // GPRS init if not started
    if (gprs && !(flags & SIM908_FLAG_GPRS_STARTED)) {
        // Need to set full functionality?
        if (flags & SIM908_FLAG_NEED_FUNC) {
            syslog(LOG_INFO, "sim908 set full functionality");

            // Set full functionallity
            ok = uart_send_command(SIM908_UART, "AT+CFUN=1",1,  NULL, 0, 5000, 1, "OK");
            if (!ok) {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_INIT));
                return ERR_INIT;
            }
            
            syslog(LOG_INFO, "sim908 full functionality");
        }

        // Need PIN?
        if (flags & SIM908_FLAG_NEED_PIN) {
            syslog(LOG_INFO, "sim908 setting PIN");

            // Set PIN
            ok = sim908_set_pin();
            if (ok != ERR_OK) {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ok));
                return ERR_PIN;
            }
            
            syslog(LOG_INFO, "sim908 PIN accepted");
        }

        // Waiting for call ready
        syslog(LOG_INFO, "sim908 waiting for call ready");

        if (gprs) {
            // Wait for Call Ready. So GPRS
            int retries = 0;

            for(;;) {
                if (retries > 60) {
                    syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_INIT));
                    return ERR_INIT;                
                }

                uart_send_command(SIM908_UART, "AT+CCALR?",1,  NULL, 0, 0, 0);
                ok = uart_wait_response(SIM908_UART, NULL, NULL, 0, 500, 1, "+CCALR: 1");
                if (ok) {
                    break;
                }

                retries++;
            }            
        }
       
        ok = uart_wait_response(SIM908_UART, NULL, NULL, 0, 3000, 1, "OK");
        if (!ok) {
            syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_INIT));
            return ERR_INIT;
        }
        
        syslog(LOG_INFO, "sim908 ready for making calls");
    }
    
    #if USE_GPS
        if (gps && !(flags & SIM908_FLAG_GPS_STARTED)) {
            if ((flags & SIM908_FLAG_GPRS_STARTED)) {
                mtx_lock(&sio_mtx);
                ppp_pause();
                sim908_exit_data_mode();
            }
            
            // Init GPS
            ok = uart_send_command(SIM908_UART, "AT+CGPSPWR=1", 1, NULL, 0, 2000, 1, "OK");
            if (!ok) {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_INIT));
                return ERR_INIT;
            }

            ok = uart_send_command(SIM908_UART, "AT+CGPSRST=0", 1, NULL, 0, 2000, 1, "OK");
            if (!ok) {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_INIT));
                return ERR_INIT;
            }

            ok = uart_send_command(SIM908_UART, "AT+CGPSOUT=255", 1, NULL, 0, 2000, 1, "OK");
            if (!ok) {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_INIT));
                return ERR_INIT;
            }

            if ((flags & SIM908_FLAG_GPRS_STARTED)) {
                sim908_enter_data_mode();
                ppp_resume();
                mtx_unlock(&sio_mtx);
            }
        }
    #endif

    if (gprs) {
        flags |= SIM908_FLAG_GPRS_STARTED;
    }

    if (gps) {
        flags |= SIM908_FLAG_GPS_STARTED;
    }

    return ERR_OK;
}

#if USE_GPRS

// This task process stablishes ppp connection, receices packets from ppp and 
// passed it then to the TCP/IP stack when convenient
static void pppTask(void *pvParameters) {
    UNUSED_ARG(pvParameters);

    QueueHandle_t *q;        // PPP input packet queue
    u8_t          *packet;   // Received packet
    u8_t          *buffer;   // Current buffer position of received packet
    u8_t           byte;     // Received byte
    u32_t          bytes;    // Received bytes
    int            pppflags;

    int fd;
    int connected = 0;

    // Disable debug on SIM908_UART
    uart_debug(SIM908_UART, 0);
    
    syslog(LOG_INFO, "sim908 ppp task started");
    
    // Allocate space for packet
    packet = pvPortMalloc(PPPOS_RX_BUFSIZE);
    if (!packet) {
        syslog(LOG_ERR, "sim908 memory error"); 
        vTaskDelete(NULL);
    }

    buffer = packet;

    // Get UART queue
    q = uart_get_queue(SIM908_UART);

    // Init ppp
    ppp_init();
    ppp = pppos_create(&gprs_netif, &fd, linkStatusCB, &connected);    
    ppp_set_auth(ppp, PPPAUTHTYPE_PAP, "lwip", "lwip");
    ppp_connect(ppp, 0);
    
    syslog(LOG_INFO, "sim908 ppp started");

    xEventGroupSetBits(sim908Event, sim908_ppp_started);    

    no_ip_start = 0;
    
    // Read packets ...
    bytes = 0;
    pppflags = -1;

    EventBits_t uxBits;

    // Configure socket for ping
    int timeout = PING_RCV_TIMEO;
    
    ping = lwip_socket(AF_INET, SOCK_RAW, IP_PROTO_ICMP);
    lwip_setsockopt(ping, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));
         
    for(;;) {
        uxBits = xEventGroupWaitBits(sim908Event, sim908_ppp_stop | sim908_ppp_resume, pdTRUE, pdFALSE, 0);
        if (uxBits & (sim908_ppp_stop)) {
            break;
        }        

        if (uxBits & (sim908_ppp_resume)) {
            xEventGroupClearBits(sim908Event, sim908_ppp_pause | sim908_ppp_paused);   
            xEventGroupSetBits(sim908Event, sim908_ppp_resumed);   
            continue;
        }        

        uxBits = xEventGroupWaitBits(sim908Event, sim908_ppp_pause, pdFALSE, pdFALSE, 0);
        if (uxBits & (sim908_ppp_pause)) {
            xEventGroupSetBits(sim908Event, sim908_ppp_paused);   
            xEventGroupClearBits(sim908Event, sim908_ppp_resumed);   
            continue;
        }

        if (xQueueReceive(q, &byte, portTICK_PERIOD_MS * 500) == pdTRUE) {
            // Byte is received, store in buffer
            *buffer++ = byte;
            bytes++;

            // Test for packet begin / end
            if (byte == PPP_FLAG) {
                pppflags++;
            }
            
            // Test for flush
            if (((pppflags > 0) || (bytes == PPPOS_RX_BUFSIZE))) {                
                // A packet is received, pass to TCP/IP stack
                activity = 1;
                gpio_pin_set(LED_NET);
                pppos_input(ppp, packet, bytes);
                gpio_pin_clr(LED_NET);
                activity = 0;

                buffer = packet;
                bytes = 0;
                
                if (pppflags > 0) {
                    pppflags = -1;
                }
            }
        } else {
            sim908_watchdog();
        }
    }

    free(packet);
    
    ppp_close(ppp,1);
    ppp_free(ppp);
    ppp = NULL;
                        
    xEventGroupSetBits(sim908Event, sim908_ppp_stopped);    
    xEventGroupClearBits(sim908Event, 
            sim908_ppp_stop |
            sim908_ppp_pause | sim908_ppp_resume | 
            sim908_ppp_paused | sim908_ppp_resumed
    );

    // Enable debug on SIM908_UART
    uart_debug(SIM908_UART, SIM908_DEBUG);

    vTaskDelete(NULL);
}
#endif

// Init a ppp connection to gprs modem
sim908_err sim908_connect() {
    err_t ok = ERR_OK;
    int retries = 0;
    char temp_buffer[255], *c;

    syslog(LOG_INFO, "sim908 gprs waiting for carrier");

    // Wait for selector operator
    retries = 0;
    do {
        bzero(temp_buffer, sizeof (temp_buffer));
        ok = uart_send_command(SIM908_UART, "AT+COPS?", 1, temp_buffer, 1, 1000, 2, "+COPS: 0,0", "+COPS: 0");
        ok = uart_wait_response(SIM908_UART, NULL, NULL, 0, 1000, 1, "OK");

        if (strcmp(temp_buffer, "+COPS: 0") == 0) {
            retries++;
            if (retries > 50) {
                syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_NO_CARRIER));
                return ERR_NO_CARRIER;
            }
            delay(100);
        }
    } while (strcmp(temp_buffer, "+COPS: 0") == 0);

    if (!ok) {
        syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_NO_CARRIER));
        return ERR_NO_CARRIER;
    }

    // Get carrier name
    int n = 0;
    c = temp_buffer;
    while (*c) {
        if (*c == ',') {
            n++;
        }

        if (n == 2) {
            // Ignore , and "
            c++;
            c++;

            // Ignore last "
            *(c + strlen(c) - 1) = 0;

            break;
        }

        c++;
    }

    if (n == 2) {
        syslog(LOG_INFO, "sim908 carrier is \"%s\"\n", c);
    }

    // Set APN
    strcpy(temp_buffer,"AT+CGDCONT=1,\"IP\",\"");
    strcat(temp_buffer,gprs_get_apn());
    strcat(temp_buffer,"\"");

    ok = uart_send_command(SIM908_UART, temp_buffer, 1, NULL, 0, 30000, 1, "OK");
    if (!ok) {
        syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_CANT_SET_APN));
        return ERR_CANT_SET_APN;
    }

    // Connect
    syslog(LOG_INFO, "sim908 gprs connecting");
    bzero(temp_buffer, sizeof (temp_buffer));
    ok = uart_send_command(SIM908_UART, "ATD*99#", 1, temp_buffer, 0, 60000, 2, "CONNECT", "NO CARRIER");

    if (!ok) {
        syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_CANT_CONNECT));
        return ERR_CANT_CONNECT;
    }

    if (strcmp(temp_buffer, "NO CARRIER") == 0) {
        syslog(LOG_ERR, "sim908 %s", sim908_error(ERR_CANT_CONNECT));
        return ERR_CANT_CONNECT;
    }

    syslog(LOG_INFO, "sim908 gprs connected");

    // Create task for process input packets
    xTaskCreate(pppTask, "pppin", ppinTaskStack, NULL, tskIDLE_PRIORITY, &pppTask_h);
    xEventGroupWaitBits(sim908Event, sim908_ppp_started, pdTRUE, pdFALSE, portMAX_DELAY);
    
    return ERR_OK;
}

void sim908_stop(int gprs, int gps) {        
    // Stop ppp task if gprs is started and want to stop gprs
    if (gprs && (flags & SIM908_FLAG_GPRS_STARTED)) {
        syslog(LOG_INFO, "sim908 stopping gprs ...");

        mtx_lock(&sio_mtx);
        
        ppp_pause();
        ppp_stop();
        sim908_exit_data_mode();
        
        mtx_unlock(&sio_mtx);
        
        syslog(LOG_INFO, "sim908 gprs stopped");
    }

    // Update flags
    if (gprs) {
        flags &= ~SIM908_FLAG_GPRS_STARTED;
        
        xQueueReset(uart_get_queue(SIM908_UART));
    }

    if (gps) {
        flags &= ~SIM908_FLAG_GPS_STARTED;
    }

    // Power off module only if GPRS and GPS ara not started
    if (!(flags & (SIM908_FLAG_GPRS_STARTED | SIM908_FLAG_GPS_STARTED))) {
        sim908_err ok = sim908_power_off();
        if (ok == ERR_OK) {
            syslog(LOG_INFO, "sim908 is powered-off");
        } else {
            syslog(LOG_ERR, "sim908 %s", sim908_error(ok));
        }
    } 
}
#endif