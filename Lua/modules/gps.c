/*
 * Whitecat, gps Lua module
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

static int lgps_start(lua_State* L) {
    platform_gps_start();
    
    return 0;
}

static int lgps_stop(lua_State* L) {
    platform_gps_stop();
    
    return 0;    
}

static const luaL_Reg gps[] = {
    {"start", lgps_start}, 
    {"stop", lgps_stop}, 
    {NULL, NULL}
};

int luaopen_gps(lua_State* L) {
    luaL_newlib(L, gps);
    
    return 1;
}
