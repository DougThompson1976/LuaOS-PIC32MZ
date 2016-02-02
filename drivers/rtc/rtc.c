/*
 * RTC driver for pic32.
 *
 * Copyright (C) 2014 Serge Vakulenko, <serge@vak.ru>
 * 
 * 
 * Whitecat, UART driver
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

#include <time.h>
#include <syslog.h>
#include <machine/pic32mz.h>

static void rtc_set_time(int year, int month, int day, int hours, int minutes, int seconds) {
    year = year - 2000;
    
    // Set date
    RTCDATE = ((((year / 10) << 4) | (year % 10)) << 24) | 
              ((((month / 10) << 4) | (month % 10)) << 16) | 
              ((((day / 10) << 4) | (day % 10)) << 8);

    // Set time
    RTCTIME = ((((hours / 10) << 4) | (hours % 10)) << 24) | 
              ((((minutes / 10) << 4) | (minutes % 10)) << 16) | 
              ((((seconds / 10) << 4) | (seconds % 10)) << 8);
}

void rtc_init(time_t time) {
    struct tm *info;
    
    // Convert from epoch time to tm struct
    info = localtime(&time);

    syslog(LOG_INFO,"rtc setting time and date to %s",asctime(info));
    
    // Lock sequence
    SYSKEY = 0;			
    SYSKEY = UNLOCK_KEY_0;
    SYSKEY = UNLOCK_KEY_1;

    // RTCC module is disabled
    // Continue normal operation when CPU enters Idle mode
    // RTCC uses the internal 32 kHz oscillator (LPRC)
    // Real-time clock value registers can be read without concern about a rollover ripple
    // First half period of a second
    // RTCC output is not enabled
    // Disable write
    RTCCON = 0;

    // Enable write
    RTCCONSET = (1 << 3);

    rtc_set_time(info->tm_year,info->tm_mon, info->tm_mday,
                 info->tm_hour,info->tm_min, info->tm_sec);

    // Turn-on RTC
    RTCCONSET = (1 << 15);

    // Disable write
    RTCCONCLR = (1 << 3);
    
    // Unlock
    SYSKEY = 0;	

    // Wait for RTC on
    while(!(RTCCON & 0x40));
}

void rtc_update_clock() {
    int year, month, day, hours, mins, secs;
    
    int timev = RTCTIME;
    int datev = RTCDATE;

    year =  2000 +
            (((datev & (0xf0 << 24)) >> 28) * 10) + 
            (((datev & (0x0f << 24)) >> 24)) -
            1900;
            
    month = (((datev & (0xf0 << 16)) >> 20) * 10) + 
            (((datev & (0x0f << 16)) >> 16));

    day =   (((datev & (0xf0 << 8)) >> 12) * 10) + 
            (((datev & (0x0f << 8)) >> 8));
    
    hours = (((timev & (0xf0 << 24)) >> 28) * 10) + 
            (((timev & (0x0f << 24)) >> 24));
    
    mins =  (((timev & (0xf0 << 16)) >> 20) * 10) + 
            (((timev & (0x0f << 16)) >> 16));
    
    secs =  (((timev & (0xf0 << 8)) >> 12) * 10) + 
            (((timev & (0x0f << 8)) >> 8));
    
    set_time_ymdhms(year, month, day, hours, mins, secs);    
}