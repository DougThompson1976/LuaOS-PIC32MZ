#ifndef WLUA_CONF
#define WLUA_CONF

#include "whitecat.h"

#define LUA_MAXINPUT 512

#undef  LUA_ROOT
#define LUA_ROOT	"/"

#undef  LUA_LDIR
#define LUA_LDIR	LUA_ROOT "lib/share/lua/"

#undef  LUA_CDIR
#define LUA_CDIR	LUA_ROOT "lib/lua/"

#undef  LUA_COPYRIGHT
#define LUA_COPYRIGHT	"LuaOS " LUA_OS_VER " powered by " LUA_RELEASE 


// Adds in standard Lua modukes

#define LBASELIB_REG_ADDS {"dumpstack", stackDump},  
#define LBASELIB_OPEN_ADDS 

#define LINIT_REG_ADDS \
  {AUXLIB_PIO, luaopen_pio}, \
  {AUXLIB_TMR, luaopen_tmr}, \
  {AUXLIB_CAN, luaopen_can}, \
  {AUXLIB_NET, luaopen_net}, \
  {AUXLIB_ADC, luaopen_adc}, \
  {AUXLIB_SPI, luaopen_spi}, \
  {AUXLIB_MQTT, luaopen_mqtt}, \
  {AUXLIB_THREAD, luaopen_thread }, \
  {AUXLIB_SCREEN, luaopen_screen}, \
  {AUXLIB_UART, luaopen_uart}, \
  {AUXLIB_PWM, luaopen_pwm}, \
  {AUXLIB_GPS, luaopen_gps}, \
  {AUXLIB_HTTP, luaopen_http},
      
#define LINIT_OPEN_ADDS

#define LIOLIB_REG_ADDS {"receive", f_receive},
#define LIOLIB_OPEN_ADDS

#define LOSLIB_REG_ADDS \
  {"shell",     os_shell}, \
  {"history",   os_history}, \
  {"cp",        os_cp}, \
  {"ls",        os_ls}, \
  {"cd",        os_cd}, \
  {"pwd",       os_pwd}, \
  {"mkdir",     os_mkdir}, \
  {"edit",      os_edit}, \
  {"clear",     os_clear}, \
  {"cat",       os_cat}, \
  {"more",      os_more}, \
  {"dmesg",     os_dmesg}, \
  {"format",    os_format}, \
  {"sleep",     os_sleep}, \
  {"loglevel",  os_loglevel}, \
  {"logcons",   os_logcons}, \
  {"stats",     os_stats},
        
#define LOSLIB_OPEN_ADDS \
  os_constants(L);

#ifdef lbaselib_c
#undef lbaselib_c
#include <Lua/modules/lbaselib_adds.inc>
#endif

#ifdef liolib_c
#undef liolib_c
#include <Lua/modules/liolib_adds.inc>
#include <sys/syscalls/mount.h>
#endif

#ifdef loslib_c
#undef loslib_c
#include <Lua/modules/loslib_adds.inc>
#endif

#endif

