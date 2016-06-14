/*
 * Whitecat, Lora WAN Lua Module
 *
 * Copyright (C) 2015 - 2016
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.org)
 * 
 * All rights reserved.  
 *
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both that the copyright notice and this
 * permission notice and warranty disclaimer appear in supporting
 * documentation, and that the name of the author not be used in
 * advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * The author disclaim all warranties with regard to this
 * software, including all implied warranties of merchantability
 * and fitness.  In no event shall the author be liable for any
 * special, indirect or consequential damages or any damages
 * whatsoever resulting from loss of use, data or profits, whether
 * in an action of contract, negligence or other tortious action,
 * arising out of or in connection with the use or performance of
 * this software.
 */

#include "lua.h"
#include "lauxlib.h"

#include <drivers/error.h>
#include <drivers/lora/lora.h>

static int llora_setup(lua_State* L) {
    tdriver_error *error;

    lora_setup();
    
    return 0;
}

static int llora_set_DevEui(lua_State* L) {
    const char  *devEui = luaL_checkstring(L, 1);

    lora_mac_set("deveui", devEui);
    
    return 0;    
}

static int llora_set_AppEui(lua_State* L) {
    const char  *appEui = luaL_checkstring(L, 1);

    lora_mac_set("appeui", appEui);
    
    return 0;    
}

static int llora_set_AppKey(lua_State* L) {
    const char  *appKey = luaL_checkstring(L, 1);

    lora_mac_set("appkey", appKey);
    
    return 0;    
}

static int llora_get_DevEui(lua_State* L) {
    char *value = lora_mac_get("deveui");
    
    lua_pushlstring(L, value, strlen(value));
    free(value);
    
    return 1;    
}

static int llora_get_AppEui(lua_State* L) {
    char *value = lora_mac_get("appeui");
    
    lua_pushlstring(L, value, strlen(value));
    free(value);
    
    return 1;    
}

static int llora_nothing(lua_State* L) {
    return luaL_error(L, "not implemented");    
}

static const luaL_Reg lora[] = {
    {"setup",      llora_setup}, 
    {"setDevAddr", llora_nothing}, 
    {"setDevEui" , llora_set_DevEui}, 
    {"setAppEui" , llora_set_AppEui}, 
    {"setAppKey" , llora_set_AppKey}, 
    {"getDevAddr", llora_nothing}, 
    {"getDevEui" , llora_get_DevEui}, 
    {"getAppEui" , llora_get_AppEui}, 
    {NULL, NULL}
};

int luaopen_lora(lua_State* L) {
    luaL_newlib(L, lora);

    return 1;
}