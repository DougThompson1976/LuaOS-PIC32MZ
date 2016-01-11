/* 
 * File:   fat.h
 * Author: jolive
 *
 * Created on July 31, 2015, 11:49 PM
 */

#ifndef FAT_H
#define	FAT_H

#include <sys/stand/stand.h>

#define MAXBSIZE    8192
#define SBSIZE      8192

int fat_open(char *path, struct open_file *f);
int fat_close(struct open_file *f);
int fat_read(struct open_file *f, char *buf, u_int size, u_int *resid);
int fat_write(struct open_file *f, char *buf, u_int size, u_int *resid);
off_t fat_seek(struct open_file *f, off_t offset, int where);
int fat_stat(struct open_file *f, struct stat *sb);
int fat_init();
int fat_eof(struct open_file *f, int *eof);
int fat_mkdir(const char *pathname);

#endif	/* FAT_H */

