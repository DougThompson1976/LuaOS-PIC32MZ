/*
 * Whitecat, pack Lua Module
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

#define PACK_NUMBER   0b00
#define PACK_NIL      0b01
#define PACK_BOOLEAN  0b10
#define PACK_STRING   0b11

static void to_hex_string(char *buff, char *val, int len, int end) {
    int i;

    for(i=0;i<len;i++) {
        if ((((*val & 0xf0) >> 4) >= 0) && (((*val & 0xf0) >> 4) <= 9)) {
            *buff = '0' + ((*val & 0xf0) >> 4);
        }
        
        if ((((*val & 0xf0) >> 4) >= 10) && (((*val & 0xf0) >> 4) <= 15)) {
            *buff = 'A' + (((*val & 0xf0) >> 4) - 10);
        }
        buff++;

        if (((*val & 0x0f) >= 0) && ((*val & 0x0f) <= 9)) {
            *buff = '0' + (*val & 0x0f);
        }
        
        if (((*val & 0x0f) >= 10) && ((*val & 0x0f) <= 15)) {
            *buff = 'A' + ((*val & 0x0f) - 10);
        }
        buff++;  
        val++;
    }
    
    if (end) {
        *buff = 0;
    }
}

static int l_pack(lua_State *L) {
    int total = lua_gettop(L); // Number of arguments
    int type;                  // Current argument type
    int i;                     // Current argument index
    void *val;                 // Current argument value
    char *pack;                // Pack string
    int idx;                   // Current pack string index
    int header_len;            // Pack header length
    char *header;              // Header buffer
    char *cheader;             // Current position of header buffer
        
    // Sanity checks
    if (total == 0) {
        return luaL_error(L, "missing arguments");
    }
    
    // Allocate space for header
    header_len = sizeof(char) + (int)((total + (4 - 1)) / 4);

    header = (char *)malloc(header_len);
    if (!header) {
        return luaL_error(L, "not enough memory");
    }
    
    cheader = header;
    
    // Put number of packed elements in header
    *cheader = (char)total;
    
    // Allocate initial pack string, reserving space for header, and init idx
    pack = (char *)malloc(header_len * 2 + 1);
    if (!pack) {
        free(header);
        return luaL_error(L, "not enough memory");
    }
    
    idx = header_len * 2;
    
    for(i=1; i <= total;i++) {
        if ((i-1) % 4 == 0) {
            cheader++;
            *cheader = 0;
        }
        
        type = lua_type(L, i);
        switch(type) {
            case LUA_TNUMBER:
                *cheader = *cheader | (PACK_NUMBER << (6 - ((i-1) % 4)*2));

                // Get value
                val = (char *)malloc(sizeof(lua_Number));
                if (!val) {
                    free(header);
                    return luaL_error(L, "not enough memory");
                }
                *((lua_Number *)val) = luaL_checknumber(L, i);
                
                // Allocate space in pack string
                pack = (char *)realloc(pack, idx + (sizeof(lua_Number) * 2) + 1);
                if (!pack) {
                    free(header);
                    free(val);
                    return luaL_error(L, "not enough memory");
                }
                
                to_hex_string(pack + idx, (char *)val, sizeof(lua_Number), 1);
                idx = idx + (sizeof(lua_Number) * 2);
                free(val);
                break;
                
            case LUA_TNIL:
                *cheader = *cheader | (PACK_NIL << (6 - ((i-1) % 4)*2));
                break;
                
            case LUA_TBOOLEAN:
                *cheader = *cheader | (PACK_BOOLEAN << (6 - ((i-1) % 4)*2));

                // Get value
                val = (void *)malloc(sizeof(char));
                if (!val) {
                    free(header);
                    return luaL_error(L, "not enough memory");
                }
                *((char *)val) = (char)lua_toboolean(L, i);
                
                // Allocate space in pack string
                pack = (char *)realloc(pack, idx + (sizeof(char) * 2) + 1);
                if (!pack) {
                    free(header);
                    free(val);
                    return luaL_error(L, "not enough memory");
                }
                
                to_hex_string(pack + idx, (char *)val, sizeof(char), 1);
                
                idx = idx + (sizeof(char) * 2);
                free(val);
                break;                
            case LUA_TSTRING:
                *cheader = *cheader | (PACK_STRING << (6 - ((i-1) % 4)*2));

                val = (void *)lua_tostring(L, i);
                
                // Allocate space in pack string
                pack = (char *)realloc(pack, idx + (strlen(val) * 2) + 2);
                if (!pack) {
                    free(header);
                    return luaL_error(L, "not enough memory");
                }
                                
                to_hex_string(pack + idx, (char *)val, strlen(val), 1);
                idx = idx + (strlen(val) * 2);
                *(pack + idx) = '0';idx++;
                *(pack + idx) = '0';idx++;
                
                break;  
            default:
                luaL_error(L, "unsupported type (argument %d)", i);break; 
        }
    }
    
    to_hex_string(pack, (char *)header, header_len, 0);
    
    lua_pushstring(L, pack);
        
    return 1;
}

static int l_unpack(lua_State *L) {
}

static const luaL_Reg pack_map[] = {
  {"pack", l_pack},
  {"unpack", l_unpack},
  {NULL, NULL}
};

int luaopen_pack(lua_State *L) {
    luaL_newlib(L, pack_map);

    return 1;
}