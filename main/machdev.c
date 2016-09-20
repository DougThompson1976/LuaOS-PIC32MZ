/*
 * Whitecat, machine device init
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

#include <drivers/console/console.h>

#include <stdio.h>
#include <fcntl.h>

#include <unistd.h>
#include <syslog.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

#include <sys/syscalls/mount.h>

#include <main/build.h>

char environ[100];
const char *__progname = "whitecat";

#include <sys/filedesc.h>
#include <sys/file.h>

static int create_folder(char *path) {
    struct stat s;

    if (stat(path, &s) < 0) {
        if (errno == ENOENT) {
            syslog(LOG_INFO, "creating %s folder",path);
            mkdir(path, 0);
            
            return 1;
        }
    }    
    
    return 0;
}

void mach_dev() {    
    mips_ei();

    console_init();
    console_clear();
    cpu_init();
    
    // Open standard file descriptors
    open(CONSOLE_TTY, O_RDONLY); // stdin
    open(CONSOLE_TTY, O_WRONLY); // stdout
    open(CONSOLE_TTY, O_WRONLY); // stderr	

    console_clear();
    
    printf("  /\\       /\\\n");
    printf(" /  \\_____/  \\\n");
    printf("/_____________\\\n");
    printf("W H I T E C A T\n\n");

    printf("LuaOS %s build %d Copyright (C) 2015 - 2016 whitecatboard.org\n\n", LUA_OS_VER, BUILD_TIME);
    
    openlog(__progname, LOG_CONS | LOG_NDELAY, LOG_LOCAL1);
    cpu_show_info();
    
    //Init filesystem  
    #if USE_CFI
        if (spiffs_init()) {
            mount_set_mounted("cfi", 1);
        }
    #endif

    #if USE_SD
        if (sd_init(0)) {
            if (fat_init()) {
                mount_set_mounted("sd", 1);
            }
        }
    #endif

    #if (USE_CFI || USE_SD)
        // Create mandatory folders on primary device
        if (primary_is_mounted()) {
            create_folder("/sys");
            create_folder("/sys/conf");
            create_folder("/sys/font");
            create_folder("/sys/zoneinfo");
            create_folder("/lib");
            create_folder("/lib/share");
            create_folder("/lib/share/lua");
            create_folder("/lib/lua");
            create_folder("/tmp");

            spiffs_copy_image("/sd/cfi-image");
        }

        if (mount_is_mounted("sd")) {
            create_folder("/sd/log");
            create_folder("/sd/lib");
            create_folder("/sd/lib/share");
            create_folder("/sd/lib/share/lua");
            create_folder("/sd/lib/lua");
            create_folder("/sd/tmp");
        }

        tzset();
    #endif

    #if USE_RTC
        rtc_init(time(NULL));
    #endif
        
    #if (USE_SD)
        if (mount_is_mounted("sd")) {
            // Redirect console messages to /log/messages.log ...
            closelog();            
            syslog(LOG_INFO, "redirecting console messages to /sd/log/messages.log ...");
            openlog(__progname, LOG_NDELAY , LOG_LOCAL1);
        } else {
            syslog(LOG_ERR, "can't redirect console messages to /sd/log/messages.log, insert an SDCARD");
        }   
    #endif
        
    // Log only errors
    setlogmask(LOG_ERR);
        
    // Continue init ...
    printf("\n");
}
