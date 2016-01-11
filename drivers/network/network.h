/*
 * Whitecat, network manager
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

#ifndef NETWORK_H
#define	NETWORK_H

#include "FreeRTOS.h"
#include "event_groups.h"
        
EventGroupHandle_t networkEvent;
EventGroupHandle_t netTaskEvent;

#define evEthernet_start      ( 1 << 0 )
#define evEthernet_stop       ( 1 << 1 )
#define evEthernet_link_up    ( 1 << 2 )
#define evEthernet_link_down  ( 1 << 3 )
#define evGprs_start          ( 1 << 4 )
#define evGprs_stop           ( 1 << 5 )
#define evGprs_restart        ( 1 << 6 )
#define evGprs_link_up        ( 1 << 7 )
#define evGprs_link_down      ( 1 << 8 )
#define evGprs_started        ( 1 << 9 )
#define evGprs_stopped        ( 1 << 10)

#define evNetTask_started     ( 1 << 0 )
#define evNetTask_stopped     ( 1 << 1 )
#define evNetTask_failed      ( 1 << 2 )

#define NET_YET_STARTED 1
#define NET_UNKNOW_INTERFACE 2
#define NET_TIMEOUT 3
#define NET_ERROR 4
#define NET_NOT_YET_STARTED 5
#define NET_NOT_SETUP 6

void netTask(void *pvParameters);
int netStart(const char *interface);
int netStop(const char *interface);
const char *netStrError(int error);
int netSntpStart();
int netStarted(const char *interface);
void netSetupGprs(const char *apn, const char *pin);

#endif	/* NETWORK_H */

