#include "lua.h"
#include "lauxlib.h"

int stackDump(lua_State *L) {
    int i;
    int top = lua_gettop(L);

    printf("top %d\n", top);
    printf("------------------------\n");

    for (i = 1; i <= top; i++) {  /* repeat for each level */
      int t = lua_type(L, i);
      switch (t) {

        case LUA_TSTRING:  /* strings */
          printf("%d: ", i);
          printf("`%s'\n", lua_tostring(L, i));
          break;

        case LUA_TBOOLEAN:  /* booleans */
          printf("%d: ", i);
          printf(lua_toboolean(L, i) ? "true" : "false");
          printf("\n");
          break;

        case LUA_TNUMBER:  /* numbers */
          printf("%d: ", i);
          printf("%g\n", lua_tonumber(L, i));
          break;

        default:  /* other values */
          printf("%d: ", i);
          printf("%s\n", lua_typename(L, t));
          break;

      }
    }
    printf("\n\n");  /* end the listing */
    
    return 0;
}


static int luaB_try (lua_State *L) {
    int total = lua_gettop(L);
    
    int tryFunc, catchFunc, finallyFunc;

    if (total == 3) {
        luaL_checktype(L, 1, LUA_TFUNCTION);
        finallyFunc = luaL_ref(L, LUA_REGISTRYINDEX);
        total--;
    }
    
    if (total == 2) {
        luaL_checktype(L, 1, LUA_TFUNCTION);
        catchFunc = luaL_ref(L, LUA_REGISTRYINDEX);
        total--;        
    }

    luaL_checktype(L, 1, LUA_TFUNCTION);
    tryFunc = luaL_ref(L, LUA_REGISTRYINDEX);

    // Call try function
    lua_rawgeti(L, LUA_REGISTRYINDEX, tryFunc);
    
    int status = lua_pcall(L, 0, 0, 0); 
    if (status != LUA_OK) {
        if (catchFunc) {
            const char *msg = lua_tostring(L, -1);
            lua_remove(L, -2);
            
            // Call fails, call to catch function
            lua_rawgeti(L, LUA_REGISTRYINDEX, catchFunc); 
            lua_pushstring(L, msg);            
            lua_pcall(L, 1, 0, 0);    

            luaL_unref(L, LUA_REGISTRYINDEX, catchFunc);
        }
    }
    
    if (finallyFunc) {
       // Call finally
        lua_rawgeti(L, LUA_REGISTRYINDEX, finallyFunc);
        lua_pcall(L, 0, 0, 0); 
        luaL_unref(L, LUA_REGISTRYINDEX, finallyFunc);
    }
    
    luaL_unref(L, LUA_REGISTRYINDEX, tryFunc);
    
    return 0;
}
