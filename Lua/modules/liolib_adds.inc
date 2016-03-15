#include "whitecat.h"
#include "lauxlib.h"

#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h> 
#include <param.h>
#include <stdio.h>
#include <syslog.h>

#include <drivers/uart/uart.h>

#define l_getc(f)		getc(f)
#define l_lockfile(f)		((void)0)
#define l_unlockfile(f)		((void)0)

static int read_line (lua_State *L, FILE *f, int chop) {
  luaL_Buffer b;
  int c = '\0';
  luaL_buffinit(L, &b);
  
  int nl = '\n';
  
  if (f == stdin) {
      nl = '\r';
  }
  
  while (c != EOF && c != nl) {  /* repeat until end of line */
    char *buff = luaL_prepbuffer(&b);  /* pre-allocate buffer */
    int i = 0;
    l_lockfile(f);  /* no memory errors can happen inside the lock */
    while (i < LUAL_BUFFERSIZE && (c = l_getc(f)) != EOF && c != nl) {
      buff[i++] = c;
    
      if (f == stdin) {
          putc(c, stdout);
      }
    }
    
    l_unlockfile(f);
    luaL_addsize(&b, i);
  }
  if (!chop && c == nl)  /* want a newline and have one? */
    luaL_addchar(&b, c);  /* add ending newline to result */
  luaL_pushresult(&b);  /* close buffer */
  /* return ok if read something (either a newline or something else) */
  return (c == nl || lua_rawlen(L, -1) > 0);
}

static int f_receive (lua_State *L) {
    const char *filename = luaL_optstring(L, 1, "");
    unsigned int i;
    int done;

    unsigned char chunk[255];
    unsigned char *cchunk;
    unsigned char chunk_size;
  
    if (strlen(filename) == 0) return 0;

    FILE *f= fopen(filename, "w");
    if (f) {
        fclose(f);
        
        // Remove file
        if (unlink(filename) < 0) {
            return luaL_error(L, strerror(errno));
        }
        
        // Re-open file
        FILE *f= fopen(filename, "w");
        if (!f) {
            return luaL_error(L, strerror(errno));
        }
        
        // Lock tty, avoid other threads to write to console
        tty_lock();
        
        // Send 'C' for start
        uart_write(CONSOLE_UART, 'C');
        uart_write(CONSOLE_UART, '\n');

        done = 0;

        for(;;) {
            // Wait for chunk size
            if (!uart_read(CONSOLE_UART, &chunk_size, 1000)) {
                break;
            }

            // More chunks?
            if (chunk_size == 0) {
                done = 1;
                break;
            }

            // Read chunk
            cchunk = chunk;
            for(i=0; i < chunk_size; i++) {
                if (!uart_read(CONSOLE_UART, cchunk++, 1000)) {
                    break;
                }
            }

            // Wrhite chunk to disk
            cchunk = chunk;
            for(i=0; i < chunk_size; i++) {
                fwrite(cchunk++,1,1,f);
            }

            // Send 'C' for start
            uart_write(CONSOLE_UART, 'C');
            uart_write(CONSOLE_UART, '\n');
        }
                
        fclose(f);
        
        if (!done) {
            // Send NACK
            uart_write(CONSOLE_UART, '\x15');
            uart_write(CONSOLE_UART, '\n');

            // Unlock tty, permit other threads to write to console
            tty_unlock();
            
            return luaL_error(L, "timeout");
        }
        
        // Send ACK
        uart_write(CONSOLE_UART, '\x06');
        uart_write(CONSOLE_UART, '\n');
        
        // Unlock tty, permit other threads to write to console
        tty_unlock();
    } else {
        return luaL_error(L, strerror(errno));
    }
    
    lua_pushboolean(L, 1);
    return 1;
}

#undef l_getc
#undef l_lockfile
#undef l_unlockfile