int lua_shell_on = SHELL_DEFAULT_STATE;

int stackDump (lua_State *L) {
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

static int lshell(lua_State *L) { 
    luaL_checktype(L, 1, LUA_TBOOLEAN);
    lua_shell_on = lua_toboolean( L, 1 );
    
    return 0;
}