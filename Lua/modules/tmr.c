// Module for interfacing with timers

#include "lauxlib.h"
#include "elua_platform.h"
#include "platform_conf.h"
#include "common.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int tmr_delay_ms( lua_State* L ) {
  timer_data_type period;
  
  period = luaL_checkinteger( L, 1 );
  delay(period);
  return 0;
}

static int tmr_delay_us( lua_State* L )
{
  timer_data_type period;
  
  period = luaL_checkinteger( L, 1 );
  udelay(period);
  return 0;
}

#include "lrodefs.h"
const luaL_Reg tmr_map[] = {
  { LSTRKEY( "delayms" ), LFUNCVAL( tmr_delay_ms ) },
  { LSTRKEY( "delayus" ), LFUNCVAL( tmr_delay_us ) },
  { LNILKEY, LNILVAL }
};

LUALIB_API int luaopen_tmr( lua_State *L ) {
#if LUA_OPTIMIZE_MEMORY > 0
  return 0;
#else // #if LUA_OPTIMIZE_MEMORY > 0
  luaL_register( L, AUXLIB_TMR, tmr_map );
#if VTMR_NUM_TIMERS > 0
  // Set this table as its own metatable
  lua_pushvalue( L, -1 );
  lua_setmetatable( L, -2 );  
#endif // #if VTMR_NUM_TIMERS > 0
  MOD_REG_INTEGER( L, "SYS_TIMER", PLATFORM_TIMER_SYS_ID );
#ifdef HAS_TMR_MATCH_INT
  MOD_REG_NUMBER( L, "INT_ONESHOT", PLATFORM_TIMER_INT_ONESHOT );
  MOD_REG_NUMBER( L, "INT_CYCLIC", PLATFORM_TIMER_INT_CYCLIC );
#endif //#ifdef HAS_TMR_MATCH_INT
  MOD_REG_INTEGER( L, "USEC", 1 );
  MOD_REG_INTEGER( L, "MSEC", 1000 );
  MOD_REG_INTEGER( L, "SEC", 1000000 );
  return 1;
#endif // #if LUA_OPTIMIZE_MEMORY > 0
}
