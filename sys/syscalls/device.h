#ifndef DEVICE_H
#define	DEVICE_H

#include <cdefs.h>

#ifndef KERNEL
#define KERNEL
#include <sys/file.h>
#undef KERNEL
#else
#include <sys/file.h>
#endif

struct  devops {
    int (*fo_open) __P((struct file *fp, int flags));
    int (*fo_read)  __P((struct file *fp, struct uio *uio,
                        struct ucred *cred));
    int (*fo_write) __P((struct file *fp, struct uio *uio,
                        struct ucred *cred));
    int (*fo_ioctl) __P((struct file *fp, u_long com,
                        caddr_t data));
    int (*fo_select) __P((struct file *fp, int which));
    int (*fo_stat) __P((struct file *fp, struct stat *sb));
    int (*fo_close) __P((struct file *fp));
    int (*fo_opendir) __P((struct file *fp));
    int (*fo_readdir) __P((struct file *fp, struct dirent *ent));
    int (*fo_unlink) __P((struct file *fp));
    off_t (*fo_seek) __P((struct file *fp, off_t offset, int where));
    int (*fo_rename) __P((const char *old_filename, const char *new_filename));
    int (*fo_mkdir) __P((const char *pathname));
    int (*fo_format) ();
};
    
struct device {
    const char *d_name;
    struct  devops d_ops;  
};

struct devops *getdevops(const char *devname);

#endif	/* DEVICE_H */

