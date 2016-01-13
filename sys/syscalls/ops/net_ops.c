/*
 * Whitecat, NETWORK wrapper functions
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

#include <stdio.h>
#include <stdlib.h>
#include <sys/param.h>
#include <sys/filedesc.h>
#include <sys/file.h>
#include <sys/uio.h>
#include <sys/stat.h>
#include <syslog.h>
#include <string.h>
#include <fcntl.h>

#include "lwip/opt.h"
#include "lwip/sockets.h"

extern struct filedesc *p_fd;

int net_select(struct file *fp, int which) {
    fd_set lreadset;
    fd_set lwriteset;
    fd_set lexceptset;
    
    struct timeval timeout = {0,0}; // 0 seconds
    int fd = *((int *)fp->f_data);
    
    FD_ZERO(&lreadset);
    FD_ZERO(&lwriteset);
    FD_ZERO(&lexceptset);

    switch (which) {
        case FREAD:  FD_SET(fd, &lreadset);   break;
        case FWRITE: FD_SET(fd, &lwriteset);  break;
        case 0:      FD_SET(fd, &lexceptset); break;
    }
    
    return lwip_select(fd + 1, &lreadset, &lwriteset, &lexceptset, &timeout);
}


int net_open(struct file *fp, int flags) {
    printf("net open: %d\n",*((int *)fp->f_data));
/*
    int unit;
    
    if (strncmp(path,"/dev/socket", 11) == 0) {
        path = path + 11;
        if ((*path >= '0') && (*path <= '9')) {
            unit = (*path) - '0';
            if (unit != *((int *)f->f_devdata)) {
                return 1;
            } else{
                path++;
                if (*path != '\0') {
                    return 1;
                } else {
                    fd_to_socket[fd] = unit;
                    socket_to_fd[unit] = fd;
                    
                    return 0;
                }
            } 
        } else {
            return 1;
        }
    } else {
        return 1;
    }
*/
}

int net_close(struct file *fp) {
    return lwip_close(*((int *)fp->f_data));
}

int net_read(struct file *fp, struct uio *uio, struct ucred *cred) {
    struct iovec *iov = uio->uio_iov;
    int fd = *((int *)fp->f_data);
    int size, br, i;
    
    for(i=0; i < uio->uio_iovcnt; i++) {
        br = lwip_recv(fd, iov->iov_base, iov->iov_len, 0);
        if (br >= 0) {
            uio->uio_resid = uio->uio_resid - br;
        } else {
            return errno;
        }
        
        iov++;
    }
    
    return 0;
}

int net_write(struct file *fp, struct uio *uio, struct ucred *cred) {    
    struct iovec *iov = uio->uio_iov;
    int fd = *((int *)fp->f_data);
    int size, bw, i;
    
    for(i=0; i < uio->uio_iovcnt; i++) {
        if (iov->iov_len > 0) {      
            bw = lwip_send(fd, iov->iov_base, iov->iov_len, 0);
            if (bw >= 0) {
                uio->uio_resid = uio->uio_resid - bw;
            } else {
                return errno;
            }
        }
        
        iov++;
    }
    
    return 0;
}

int net_stat(struct file *fp, struct stat *sb) {
    printf("net stat: %d\n",*((int *)fp->f_data));
}

int net_ioctl(struct file *fp, u_long com, caddr_t data) {
    return lwip_ioctl(*((int *)fp->f_data), com, data);
}