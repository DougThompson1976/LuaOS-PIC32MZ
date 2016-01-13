/*
 * Whitecat, network manager
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
#include "timers.h"
#include "event_groups.h"

#if USE_ETHERNET || USE_GPRS || USE_WIFI

#include "drivers/sim908/sim908.h"
#include "drivers/network/network.h"

#include "mch.h"
#include "lwip/dhcp.h"
#include "lwip/sntp.h"
#include "lwip/inet.h"
#include "lwip/tcp.h"
#include "lwip/ip_frag.h"
#include "lwip/netif.h"
#include "lwip/init.h"
#include "lwip/stats.h"
#include "netif/ethernetif.h"
#include "netif/etharp.h"
#include "lwip/ip_addr.h"
#include "netif/ppp/ppp.h"
#include "lwip/tcpip.h"

static const char *net_error[] = {
    NULL,
    "Service yet started",
    "Unknow interface",
    "Network timeout",
    "Network error",
    "Service not yet started",
    "Interface not setup"
};

// Started services
static int sntp_started = 0;

// Interfaces mannaged by this network mannager
struct netif eth_netif;
struct netif gprs_netif;
struct netif wifi_netif;

static int eth_started = 0;
static int gprs_started = 0;
static int wifi_started = 0;

static int eth_setup = 0;
static int gprs_setup = 0;
static int wifi_setup = 0;

// External references
extern int  ethernet_init(void);

// DNS address
ip_addr_t  dns1;
ip_addr_t  dns2;

int netStarted(const char *interface) {
    if (strcmp(interface,"en") == 0) {
        return eth_started;
    }

    if (strcmp(interface,"gprs") == 0) {
        return gprs_started;
    }
}

int netSetup(const char *interface) {
    if (strcmp(interface,"en") == 0) {
        return eth_setup;
    }

    if (strcmp(interface,"gprs") == 0) {
        return gprs_setup;
    }
    
    return 0;
}

const char *netStrError(int error) {
    return net_error[error];
}

// Thiscall back is called from the TCP/IP thread when the stack is available.
// When available we can set the connections and stack services required.
static void tcpip_init_done(void *arg) {
    UNUSED_ARG(arg);

    dns1.addr = DNS1;
    dns2.addr = DNS2;

    dns_setserver(0,&dns1);
    dns_setserver(1,&dns2);
}

// This function sets the default interface, according to this priorities
//
// 1) Ethernet
// 2) Wifi
// 3) GPRS
void set_default_interface() {
    if (eth_netif.flags & NETIF_FLAG_LINK_UP) {
        netif_set_default(&eth_netif);
    } else {
        if (wifi_netif.flags & NETIF_FLAG_LINK_UP) {

        } else {
            if (gprs_netif.flags & NETIF_FLAG_LINK_UP) {
                netif_set_default(&gprs_netif);
            }
        }
    }
}

void netTask(void *pvParameters) {
    UNUSED_ARG(pvParameters);

    EventBits_t uxBits;

    networkEvent = xEventGroupCreate();
    netTaskEvent = xEventGroupCreate();

    // Init TCP/IP stack, this create a thread for the stack
    tcpip_init(tcpip_init_done, NULL);

    for(;;) {
        // Wait for network events ...
        uxBits = xEventGroupWaitBits(networkEvent, 
                    evEthernet_start | evGprs_start | evEthernet_stop | 
                    evGprs_stop | evEthernet_link_up | evEthernet_link_down | 
                    evGprs_link_up | evGprs_link_down | evGprs_restart | 
                    evGprs_started | evGprs_stopped
                    ,pdTRUE, pdFALSE, portTICK_PERIOD_MS * 100
        );
        
        if (uxBits & (evEthernet_start)) {
            if (ethernet_init()) {
                xEventGroupSetBits(netTaskEvent, evNetTask_failed);                
            }
        }

        if (uxBits & (evGprs_start)) {
            if (gprs_start()) {
                xEventGroupSetBits(netTaskEvent, evNetTask_failed);                
            }
        }
        
        if (uxBits & (evEthernet_stop)) {
            ethernet_stop();          
            xEventGroupSetBits(netTaskEvent, evNetTask_stopped);
        }
        
        if (uxBits & (evGprs_stop)) {
            gprs_stop();          
            xEventGroupSetBits(networkEvent, evGprs_stopped);
        }

        if (uxBits & (evEthernet_link_up | evGprs_link_up)) {
            set_default_interface();

            if (uxBits & (evGprs_started | evEthernet_started)) {
                xEventGroupSetBits(netTaskEvent, evNetTask_started);
            }
        }

        if (uxBits & (evEthernet_link_down | evGprs_link_down)) {
            set_default_interface();      
            
            if (uxBits & (evGprs_restart)) {
                gprs_stop();
                gprs_start();            
            }

            if (uxBits & (evGprs_stopped)) {
                xEventGroupSetBits(netTaskEvent, evNetTask_stopped);
            }
        }
    }
    
    if (networkEvent) {
        vEventGroupDelete(networkEvent);
    }
    
    vTaskDelete(NULL);
}

int netSntpStart() {
    if (sntp_started) {
        return NET_YET_STARTED;
    }
    
    if (!eth_started && !gprs_started) {
        return NET_ERROR;
    }
    
    sntp_init();
    sntp_started = 1;
    
    return 0;
}

void netSetupGprs(const char *apn, const char *pin) {
    gprs_set_apn(apn);
    gprs_set_pin(pin);
    
    gprs_setup = 1;
}

int netStart(const char *interface) {
    EventBits_t uxBits;
    
    if (strcmp(interface,"en") == 0) {
        if (netStarted(interface)) {
            return NET_YET_STARTED;
        }
        
        xEventGroupSetBits(networkEvent, evEthernet_start);  
        uxBits = xEventGroupWaitBits(netTaskEvent, evNetTask_started |  evNetTask_failed, pdTRUE, pdFALSE, portTICK_PERIOD_MS * 8000);
        if (uxBits & evNetTask_started) {
            eth_started = 1;
            return 0;
        } else if (uxBits & evNetTask_failed) {
            return NET_ERROR;
        } else {
            return NET_TIMEOUT;
        }
    }
    
    if (strcmp(interface,"gprs") == 0) {
        if (netStarted(interface)) {
            return NET_YET_STARTED;
        }

        if (!netSetup(interface)) {
            return NET_NOT_SETUP;
        }
        
        xEventGroupSetBits(networkEvent, evGprs_start);  
        
        // Don't wait for GPRS, it's so slow ...
        uxBits = xEventGroupWaitBits(netTaskEvent, evNetTask_started |  evNetTask_failed, pdTRUE, pdFALSE, portMAX_DELAY);
        if (uxBits & evNetTask_started) {
            gprs_started = 1;
            return 0;
        } else if (uxBits & evNetTask_failed) {
            return NET_ERROR;
        } else {
            return NET_TIMEOUT;
        }
    }

    return NET_UNKNOW_INTERFACE;
}

int netStop(const char *interface) {
    EventBits_t uxBits;
    
    if (strcmp(interface,"en") == 0) {
        if (!netStarted(interface)) {
            return NET_NOT_YET_STARTED;
        }

        xEventGroupSetBits(networkEvent, evEthernet_stop);
        uxBits = xEventGroupWaitBits(netTaskEvent, evNetTask_stopped, pdTRUE, pdFALSE, portTICK_PERIOD_MS * 8000);
        if (uxBits & evNetTask_stopped) {
            eth_started = 0;
            return 0;
        } else {
            return NET_TIMEOUT;
        }
    }
    
    if (strcmp(interface,"gprs") == 0) {
        if (!netStarted(interface)) {
            return NET_NOT_YET_STARTED;
        }

        xEventGroupSetBits(networkEvent, evGprs_stop);
        uxBits = xEventGroupWaitBits(netTaskEvent, evNetTask_stopped, pdTRUE, pdFALSE, portMAX_DELAY);
        if (uxBits & evNetTask_stopped) {
            gprs_started = 0;
            return 0;
        } else {
            return NET_TIMEOUT;
        }
    }

    return NET_UNKNOW_INTERFACE;
}    
    
#endif
