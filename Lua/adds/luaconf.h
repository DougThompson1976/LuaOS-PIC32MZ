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

#endif

