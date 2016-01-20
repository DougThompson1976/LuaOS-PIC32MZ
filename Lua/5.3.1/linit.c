/*
** $Id: linit.c,v 1.38 2015/01/05 13:48:33 roberto Exp $
** Initialization of libraries for lua.c and other clients
** See Copyright Notice in lua.h
*/


#define linit_c
#define LUA_LIB

/*
** If you embed Lua in your program and need to open the standard
** libraries, call luaL_openlibs in your program. If you need a
** different set of libraries, copy this file to your project and edit
** it to suit your needs.
**
** You can also *preload* libraries, so that a later 'require' can
** open the library, which is already linked to the application.
** For that, do the following code:
**
**  luaL_getsubtable(L, LUA_REGISTRYINDEX, "_PRELOAD");
**  lua_pushcfunction(L, luaopen_modname);
**  lua_setfield(L, -2, modname);
**  lua_pop(L, 1);  // remove _PRELOAD table
*/

#include "lprefix.h"


#include <stddef.h>

#include "lua.h"

#include "lualib.h"
#include "lauxlib.h"

//WHITECAT BEGIN
#include "auxmods.h"
//WHITECAT END

/*
** these libs are loaded by lua.c and are readily available to any Lua
** program
*/
static const luaL_Reg loadedlibs[] = {
  {"_G", luaopen_base},
  {LUA_LOADLIBNAME, luaopen_package},
  {LUA_COLIBNAME, luaopen_coroutine},
  {LUA_TABLIBNAME, luaopen_table},
  {LUA_IOLIBNAME, luaopen_io},
  {LUA_OSLIBNAME, luaopen_os},
  {LUA_STRLIBNAME, luaopen_string},
  {LUA_MATHLIBNAME, luaopen_math},
//  {LUA_UTF8LIBNAME, luaopen_utf8},
  {LUA_DBLIBNAME, luaopen_debug},
#if defined(LUA_COMPAT_BITLIB)
  {LUA_BITLIBNAME, luaopen_bit32},
#endif
  //WHITECAT BEGIN
  {AUXLIB_PIO, luaopen_pio},
  {AUXLIB_TMR, luaopen_tmr},
  {AUXLIB_CAN, luaopen_can},
  {AUXLIB_NET, luaopen_net},
  {AUXLIB_ADC, luaopen_adc},
  {AUXLIB_SPI, luaopen_spi},
  {AUXLIB_MQTT, luaopen_mqtt},
  {AUXLIB_THREAD, luaopen_thread },
  {AUXLIB_SCREEN, luaopen_screen},
  {AUXLIB_UART, luaopen_uart},
  {AUXLIB_PWM, luaopen_pwm},
#if USE_GPS
  {AUXLIB_GPS, luaopen_gps},
#endif
#if USE_HTTP
  {AUXLIB_HTTP, luaopen_http},
#endif
  //WHITECAT END
  {NULL, NULL}
};

LUALIB_API void luaL_openlibs (lua_State *L) {
  const luaL_Reg *lib;
  /* "require" functions from 'loadedlibs' and set results to global table */
  for (lib = loadedlibs; lib->func; lib++) {
    luaL_requiref(L, lib->name, lib->func, 1);
    lua_pop(L, 1);  /* remove lib */
  }
}

