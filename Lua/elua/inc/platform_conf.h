// eLua platform configuration

#ifndef __PLATFORM_CONF_H__
#define __PLATFORM_CONF_H__

#include "whitecat.h"
#include "drivers/console/console.h"
#include "drivers/gpio/gpio.h"

#include "FreeRTOS.h"
#include "timers.h"

#include "auxmods.h"

#define dlmalloc  malloc
#define dlfree    free
#define dlcalloc  calloc
#define dlrealloc realloc

//#define USE_MULTIPLE_ALLOCATOR
#define BUILD_CON_GENERIC
//#define BUILD_SHELL
//#define BUILD_ADVANCED_SHELL
//#define BUILD_TERM
//#define BUILD_ROMFS
//#define BUILD_XMODEM
#define BUILD_LINENOISE
#define BUILD_MMCFS
//#define BUILD_ADC

//#define MMCFS_SPI_NUM   SD_SPI
//#define MMCFS_NUM_CARDS 1
//#define MMCFS_CS_PORT   PORB(SD_CS)
//#define MMCFS_CS_PIN    PINB(SD_CS)

//#define LINENOISE_HISTORY_SIZE_LUA 10
//#define LINENOISE_HISTORY_SIZE_SHELL 10

//#define VTMR_NUM_TIMERS 4
//#define SERMUX_SERVICE_ID_FIRST -1
//#define VTMR_FREQ_HZ configTICK_RATE_HZ

// *****************************************************************************
// UART/Timer IDs configuration data (used in main.c)

#define CON_UART_ID           CONSOLE_UART
#define CON_TIMER_ID          0
#define CON_UART_SPEED        CONSOLE_BR
#define TERM_LINES            50
#define TERM_COLS             80

#define PLATFORM_HAS_SYSTIMER

// *****************************************************************************
// Auxiliary libraries that will be compiled for this platform

#define LUA_PLATFORM_LIBS_ROM\
  _ROM( LUA_MATHLIBNAME, luaopen_math, math_map )\
  _ROM( AUXLIB_ELUA, luaopen_elua, elua_map )\
  _ROM( AUXLIB_TMR, luaopen_tmr, tmr_map )\
  _ROM( AUXLIB_PIO, luaopen_pio, pio_map )\
  _ROM( AUXLIB_PD, luaopen_pd, pd_map ) \
  _ROM( AUXLIB_TERM, luaopen_term, term_map )


// *****************************************************************************
// Configuration data

#define EGC_INITIAL_MODE      1

// Number of resources (0 if not available/not implemented)
//#define NUM_PIO               6
//#define NUM_SPI               4
#define NUM_UART              4
#define NUM_TIMER             0
#define NUM_PHYS_TIMER        0
#define NUM_PWM               0
#define NUM_ADC               0
#define NUM_CAN               NCAN

// PIO prefix ('0' for P0, P1, ... or 'A' for PA, PB, ...)
//#define PIO_PREFIX            'A'
// Pins per port configuration:
// #define PIO_PINS_PER_PORT (n) if each port has the same number of pins, or
// #define PIO_PIN_ARRAY { n1, n2, ... } to define pins per port in an array
// Use #define PIO_PINS_PER_PORT 0 if this isn't needed
//#define PIO_PIN_ARRAY         { 16, 16, 16, 16, 8, 12, 7, 0, 0, 0, 0, 0, 0, 0, 14, 12 }

//#define LINENOISE_HISTORY_SIZE_LUA    50
//#define LINENOISE_HISTORY_SIZE_SHELL  10

// Interrupt queue size
#define PLATFORM_INT_QUEUE_LOG_SIZE 5

//char lua_mem[1];

// Allocator data: define your free memory zones here in two arrays
// (start address and end address)
//#define SRAM_SIZE             ( 64 * 1024 )
//#define SRAM_BASE             0x20000000
//
//#define MEM_START_ADDRESS     { ( void* )&lua_mem[0] }
//#define MEM_END_ADDRESS       { ( void* )&lua_mem[1] }

//#define MEM_START_ADDRESS     { ( void* )end }
//#define MEM_END_ADDRESS       { ( void* )( SRAM_BASE + SRAM_SIZE - STACK_SIZE_TOTAL - 1 ) }

#endif // #ifndef __PLATFORM_CONF_H__

