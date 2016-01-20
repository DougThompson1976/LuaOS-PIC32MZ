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

extern int falloc(struct file **resultfp, int *resultfd);
extern struct file *getfile(int fd);

int socket(int domain, int type, int protocol) {
    struct file *fp;
    int *socket;
    int error;
    int fd;
    
    // Allocate space for socket number
    socket = malloc(sizeof(int));
    if (!socket) {
        errno = ENOMEM;
        return -1;
    }
    
    // Allocate a new file descriptor for the socket
    error = falloc(&fp, &fd);
    if (error) {
        errno = error;
        free(socket);
        
        return -1;
    }
    
    // File descriptor type SOCKET
    fp->f_type = DTYPE_SOCKET;
    fp->f_flag = FWRITE | FREAD;
    
    *socket = lwip_socket(domain,type,protocol);
    if (*socket < 0) {
        free(socket);
        ffree(fp);
        return -1;
    } else {
        fp->f_data = (caddr_t)socket;

        setfops(fp, "net");

        return fd;
    }
}
    
int accept(int fd, struct sockaddr *addr, socklen_t *addrlen) {
    struct file *nfp;
    struct file *fp;
    struct filedesc *fdp = p_fd;
    int *nsocket;
    int nfd;
    int error;
 
    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    // Allocate space for new socket number
    nsocket = malloc(sizeof(int));
    if (!nsocket) {
        errno = ENOMEM;
        return -1;
    }
    
    // Allocate a new file descriptor for the socket
    error = falloc(&nfp, &nfd);
    if (error) {
        free(nsocket);
        
        errno = error;
        return -1;
    }

    // File descriptor type SOCKET
    nfp->f_type = DTYPE_SOCKET;
    nfp->f_flag = fp->f_flag;
    
    *nsocket =  lwip_accept( *((int *)fp->f_data), addr, addrlen);
    if (*nsocket < 0) {
        free(nsocket);
        ffree(nfp);
        return -1;
    } else {
        nfp->f_data = (caddr_t)nsocket;

        setfops(nfp, "net");

        return nfd;
    }
}

int bind(int fd, const struct sockaddr *name, socklen_t namelen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_bind( *((int *)fp->f_data), name, namelen);
}

int shutdown(int fd, int how) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_shutdown( *((int *)fp->f_data), how);
}

int closesocket(int fd) {
    return close(fd);
}

int getsockname(int fd, struct sockaddr *name, socklen_t *namelen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_getsockname(*((int *)fp->f_data), name, namelen);
}

int getpeername(int fd, struct sockaddr *name, socklen_t *namelen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_getpeername(*((int *)fp->f_data), name, namelen);  
}

int connect(int fd, const struct sockaddr *name, socklen_t namelen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_connect(*((int *)fp->f_data), name, namelen);   
}

int setsockopt(int fd, int level, int optname, const void *optval, socklen_t optlen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_setsockopt(*((int *)fp->f_data), level, optname, optval, optlen);     
}

int getsockopt(int fd, int level, int optname, void *optval, socklen_t *optlen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_getsockopt(*((int *)fp->f_data), level, optname, optval, optlen);        
}

int listen(int fd, int backlog) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_listen(*((int *)fp->f_data), backlog);
}

int recvfrom(int fd, void *mem, size_t len, int flags,
              struct sockaddr *from, socklen_t *fromlen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_recvfrom(*((int *)fp->f_data), mem, len, flags, from, fromlen);
}


int recv(int fd, void *mem, size_t len, int flags) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_recvfrom(*((int *)fp->f_data), mem, len, flags, NULL, NULL);
}

int send(int fd, const void *data, size_t size, int flags) {    
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_send(*((int *)fp->f_data), data, size, flags);
}

int sendto(int fd, const void *data, size_t size, int flags,
       const struct sockaddr *to, socklen_t tolen) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_sendto(*((int *)fp->f_data), data, size, flags, to, tolen);
}

int ioctlsocket(int fd, long cmd, void *argp) {
    struct file *fp;
    struct filedesc *fdp = p_fd;

    fp = getfile(fd);
    if (!fp) {
        return -1;
    }

    return lwip_ioctl(*((int *)fp->f_data), cmd, argp);
}