// Rename main in lua.c with lua_main
// Remove get_prompt in lua.c
// Rename pushline to luaos_pushline in lua.c

#ifndef WLUA_CONF
#define WLUA_CONF

#include "whitecat.h"
#include "auxmods.h"

#include <unistd.h>

#define log2 log
#define LUA_PROMPT		"> "
#define LUA_PROMPT2		">> "


#define LUA_MAXINPUT 512

#undef  LUA_ROOT
#define LUA_ROOT	"/"

#undef  LUA_LDIR
#define LUA_LDIR	LUA_ROOT "lib/share/lua/"

#undef  LUA_CDIR
#define LUA_CDIR	LUA_ROOT "lib/lua/"

#undef  LUA_COPYRIGHT
#define LUA_COPYRIGHT	"LuaOS " LUA_OS_VER " powered by " LUA_RELEASE 

#undef  LUAI_THROW
#define LUAI_THROW(L,c)		_longjmp((c)->b, 1)

#undef  LUAI_TRY
#define LUAI_TRY(L,c,a)		if (_setjmp((c)->b) == 0) { a }

#undef  luai_jmpbuf
#define luai_jmpbuf		jmp_buf

#define LUA_TMPNAMBUFSIZE	32

#if !defined(LUA_TMPNAMTEMPLATE)
#define LUA_TMPNAMTEMPLATE	"/tmp/lua_XXXXXX"
#endif

#define lua_tmpnam(b,e) { \
        strcpy(b, LUA_TMPNAMTEMPLATE); \
        e = mkstemp(b); \
        if (e != -1) close(e); \
        e = (e == -1); }


//#include <Lua/common/linenoise.h>
//#include "lstate.h"

#undef  lua_readline
#define lua_readline(L,b,p)     ((void)L, (linenoise(b, p)) != -1)

#define lua_saveline(L,idx)     { (void)L; (void)idx; }
#define lua_freeline(L,b)       { (void)L; (void)b; }






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
  {AUXLIB_HTTP, luaopen_http}, \
  {AUXLIB_STEPPER, luaopen_stepper}, \
  {AUXLIB_I2C, luaopen_i2c},
      
#define LINIT_OPEN_ADDS

#define LIOLIB_REG_ADDS {"receive", f_receive}, {"send", f_send},
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
  {"idle",      os_idle}, \
  {"loglevel",  os_loglevel}, \
  {"logcons",   os_logcons}, \
  {"stats",     os_stats}, \
  {"version",   os_version}, \
  {"cpu",   os_cpu},
        
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

#ifdef lua_c
#undef lua_c

static int report (lua_State *L, int status);
static void l_message (const char *pname, const char *msg);
static int runargs (lua_State *L, char **argv, int n);
static void print_version (void);
static void doREPL (lua_State *L);
static void print_usage (const char *badoption);
static int collectargs (char **argv, int *first);
static void createargtable (lua_State *L, char **argv, int argc, int script);

/* print a string */
#if !defined(lua_writestring)
#define lua_writestring(s,l)   (tty_lock(), fwrite((s), sizeof(char), (l), stdout), tty_unlock())
#endif

/* print a newline and flush the output */
#if !defined(lua_writeline)
#define lua_writeline()        (lua_writestring("\n", 1), tty_lock(), fflush(stdout), tty_unlock())
#endif

/* print an error message */
#if !defined(lua_writestringerror)
#define lua_writestringerror(s,p) \
        (tty_lock(), fprintf(stderr, (s), (p)), fflush(stderr), tty_unlock())
#endif


#include "lauxlib.h"
#include "lualib.h"
#include <Lua/modules/lua_adds.inc>
#endif

#endif