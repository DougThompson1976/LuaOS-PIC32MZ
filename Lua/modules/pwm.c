/*
 * Whitecat, pwm Lua module
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

#include <drivers/pwm/pwm.h>

static unsigned char lpwm_mode[NOC];
static unsigned char lpwm_res[NOC];

static int lpwm_setup(lua_State* L) {
    int khz;
    double duty;
    
    int res, val;
    
    int id = luaL_checkinteger(L, 1); 
    int mode = luaL_checkinteger(L, 2); 
    
    if (!platform_pwm_exists(id)) {
        return luaL_error(L, "pwm %d does not exist", id);
    }
    
    switch (mode) {
        case 0:
            khz = luaL_checkinteger(L, 3); 
            duty = luaL_checknumber(L, 4); 
            
            lua_pushinteger(L, platform_pwm_setup_freq(id, khz, duty));
            break;
            
        case 1:
            res = luaL_checkinteger(L, 3); 
            val = luaL_checknumber(L, 4); 
            
            lua_pushinteger(L, platform_pwm_setup_res(id, res, val));
            break;
            
        default:
            return luaL_error(L, "invalid setup mode");
    }
    
    lpwm_mode[id - 1] = mode;
    lpwm_res[id - 1] = res;
    
    return 1;
}

static int lpwm_start(lua_State* L) {
    int id = luaL_checkinteger(L, 1); 

    if (!platform_pwm_exists(id)) {
        return luaL_error(L, "pwm %d does not exist", id);
    }
    
    platform_pwm_start(id);
    
    return 0;
}

static int lpwm_stop(lua_State* L) {
    int id = luaL_checkinteger(L, 1); 

    if (!platform_pwm_exists(id)) {
        return luaL_error(L, "pwm %d does not exist", id);
    }

    platform_pwm_stop(id);
    
    return 0;
}

static int lpwm_setduty(lua_State* L) {
    int id = luaL_checkinteger(L, 1); 
    double duty = luaL_checknumber(L, 2); 

    if (!platform_pwm_exists(id)) {
        return luaL_error(L, "pwm %d does not exist", id);
    }
    
    if (lpwm_mode[id - 1] != 0) {
        return luaL_error(L, "pwm %d isn't setup in FREQUENCY mode, function not allowed", id);
    }

    platform_pwm_set_duty(id, duty);
    
    return 0;
}

static int lpwm_write(lua_State* L) {
    int id = luaL_checkinteger(L, 1); 
    int val = luaL_checknumber(L, 2); 

    if (!platform_pwm_exists(id)) {
        return luaL_error(L, "pwm %d does not exist", id);
    }
    
    if (lpwm_mode[id - 1] != 1) {
        return luaL_error(L, "pwm %d isn't setup in RESOLUTION mode, function not allowed", id);
    }

    platform_pwm_write(id, lpwm_res[id - 1], val);
    
    return 0;
}

static const luaL_Reg pwm[] = {
    {"setup", lpwm_setup}, 
    {"start", lpwm_start}, 
    {"stop", lpwm_stop}, 
    {"setduty", lpwm_setduty}, 
    {"write", lpwm_write}, 
    {NULL, NULL}
};

int luaopen_pwm(lua_State* L)
{
    luaL_newlib(L, pwm);

    lua_pushinteger(L, 0);
    lua_setfield(L, -2, "DEFAULT");

    lua_pushinteger(L, 1);
    lua_setfield(L, -2, "DAC");

    int i;
    char buff[5];

    for(i=1;i<=NOC;i++) {
        sprintf(buff,"PWM%d",i);
        lua_pushinteger(L, i);
        lua_setfield(L, -2, buff);
    }

    return 1;
}
