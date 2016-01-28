#include "whitecat.h"
#include "lauxlib.h"

#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h> 
#include <param.h>
#include <stdio.h>
#include <syslog.h>

#include <drivers/uart/uart.h>

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