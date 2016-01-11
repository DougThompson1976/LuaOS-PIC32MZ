/*
 * Whitecat, GPRS driver
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

#include <syslog.h>

#include <drivers/sim908/sim908.h>

static char *apn;
static char *pin;

int gprs_start() {
    sim908_err err = sim908_init(1,0);
    if (err == ERR_OK) {
        err = sim908_connect();
        if (err != ERR_OK) {
            syslog(LOG_INFO, "sim908 %s", sim908_error(err));        
        }
    } else {
        syslog(LOG_INFO, "sim908 %s", sim908_error(err));        
    }

    return (err != ERR_OK);    
}

void gprs_stop() {
    sim908_stop();
}

void gprs_set_apn(const char *aapn) {
    if (apn) {
        free(apn);
    }
    
    apn = (char *)malloc(strlen(aapn));
    if (apn) {
        strcpy(apn, aapn);
    }
}

void gprs_set_pin(const char *apin) {
    if (pin) {
        free(pin);
    }

    pin = (char *)malloc(strlen(apin));
    if (pin) {
        strcpy(pin, apin);
    }
}

const char *gprs_get_apn() {
    return apn;
}

const char *gprs_get_pin() {
    return pin;
}