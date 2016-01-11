/*
 * Whitecat, TTY wrapper functions
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

#include <stdlib.h>
#include <sys/param.h>
#include <sys/filedesc.h>
#include <sys/file.h>
#include <sys/uio.h>
#include <sys/mutex.h>

#include <drivers/uart/uart.h>

static struct mtx tty_mtx;  /* tty mutex */
static int mtx_inited;
static int redirect_to_display;

int tty_redirect_to_display() {
    return redirect_to_display;
}

void tty_to_display(int to_display) {
    redirect_to_display = to_display;
}
int tty_open(struct file *fp, int flags) {
    redirect_to_display = 0;
    return 0;
}

int tty_close(struct file *fp) {
    return 0;
}
       
int tty_read(struct file *fp, struct uio *uio, struct ucred *cred) {
    int unit = fp->f_devunit;
    char *buf = uio->uio_iov->iov_base;
    
    while (uio->uio_iov->iov_len) {
        if (uart_read(unit, buf++, portMAX_DELAY)) {
            uio->uio_iov->iov_len--;
            uio->uio_resid--;
        } else {
            break;
        } 
    }

    return 0;
}

int tty_write(struct file *fp, struct uio *uio, struct ucred *cred) {
    int unit = fp->f_devunit;
    char *buf = uio->uio_iov->iov_base;
    char dbuf[2];
    
    dbuf[1] = '\0';
    
    if (!mtx_inited) {
        mtx_init(&tty_mtx, NULL, NULL, 0);
        mtx_inited = 1;
    }
    
    mtx_lock(&tty_mtx);

    while (uio->uio_iov->iov_len) {
        if (*buf == '\n') {
            uart_write(unit, '\r');            
        }
        
        uart_write(unit, *buf);   
      
        if (redirect_to_display) {
            dbuf[0] = *buf;
            display_text(-1,-1, NULL, -1, -1, dbuf);
        }
        
        uio->uio_iov->iov_len--;
        uio->uio_resid--;
        buf++;
    }

    mtx_unlock(&tty_mtx);
    
    return 0;
}

int tty_stat(struct file *fp, struct stat *sb) {
    sb->st_mode = S_IFCHR;
    sb->st_blksize = 1;
    sb->st_size = 1;

    return 0;
}

void tty_lock() {
    if (!mtx_inited) {
        mtx_init(&tty_mtx, NULL, NULL, 0);
        mtx_inited = 1;
    }

    mtx_lock(&tty_mtx);
}

void tty_unlock() {
    if (!mtx_inited) {
        mtx_init(&tty_mtx, NULL, NULL, 0);
        mtx_inited = 1;
    }

    mtx_unlock(&tty_mtx);
}

/*
int tty_seek(struct open_file *f, off_t offset, int where) {
    return 0;
}

int tty_stat(struct open_file *f, struct stat *sb) {
    return 0;
}

int tty_eof(struct open_file *f, int *eof) {
    *eof = 0;
    return 0;
}
*/
