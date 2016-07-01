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
    
    int status = lua_pcall(L, 0, 0, NULL); 
    if (status != LUA_OK) {
        if (catchFunc != LUA_NOREF) {
            const char *msg = lua_tostring(L, -1);
            
            const char *whereEnd = strchr(msg,':');
            const char *lineEnd = strchr(whereEnd + 1,':');

            lua_remove(L, -2);
                        
            // Call fails, call to catch function
            lua_rawgeti(L, LUA_REGISTRYINDEX, catchFunc); 
            
            lua_pushlstring(L, msg, whereEnd - msg);
            lua_pushlstring(L, whereEnd + 1, lineEnd -whereEnd - 1);
            lua_pushstring(L, lineEnd + 2);
            
            lua_pcall(L, 3, 0, NULL);    
        }
    }
    
    if (finallyFunc != LUA_NOREF) {
       // Call finally
        lua_rawgeti(L, LUA_REGISTRYINDEX, finallyFunc);
        lua_pcall(L, 0, 0, NULL); 
    }
    
    if ( tryFunc!= LUA_NOREF) luaL_unref(L, LUA_REGISTRYINDEX, tryFunc);
    if ( catchFunc!= LUA_NOREF) luaL_unref(L, LUA_REGISTRYINDEX, catchFunc);
    if ( finallyFunc!= LUA_NOREF) luaL_unref(L, LUA_REGISTRYINDEX, finallyFunc);
    
    return 0;
}
