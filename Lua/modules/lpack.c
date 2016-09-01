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

#include "whitecat.h"

#if LUA_USE_PACK

#include "lua.h"
#include "lauxlib.h"

#define PACK_NUMBER   0b0000
#define PACK_INTEGER  0b0001
#define PACK_NIL      0b0010
#define PACK_BOOLEAN  0b0011
#define PACK_STRING   0b0100

#define PACK_BITS_PER_TYPE    4
#define PACK_TYPES_PER_BYTE   (8 / PACK_BITS_PER_TYPE)
#define PACK_HEADER_LENGTH(n) \
    (sizeof(char) + (int)((n + (PACK_TYPES_PER_BYTE - 1)) / PACK_TYPES_PER_BYTE))

#define PACK_PACK_TYPE(t, n) \
(t << ((8 - PACK_BITS_PER_TYPE) - ((n-1) % PACK_TYPES_PER_BYTE)*PACK_BITS_PER_TYPE))
        
#define PACK_UNPACK_TYPE(v, n) \
((v & PACK_PACK_TYPE(0b1111, n)) >> ((8 - PACK_BITS_PER_TYPE) - ((n-1) % PACK_TYPES_PER_BYTE)*PACK_BITS_PER_TYPE))

// Convert an hex string buffer (hbuff argument) into a byte buffer (vbuff 
// argument) of len argument size
static void hex_string_to_val(unsigned char *hbuff, unsigned char *vbuff, int len) {
    int  i;
    unsigned char c;
    
    for(i=0;i<len;i++) {
        c = 0;
        if ((*hbuff >= '0') && (*hbuff <= '9')) {
            c = (0 + (*hbuff - '0')) << 4;
        }

        if ((*hbuff >= 'A') && (*hbuff <= 'F')) {
            c = (10 + (*hbuff - 'A')) << 4;
        }
        
        hbuff++;

        if ((*hbuff >= '0') && (*hbuff <= '9')) {
            c |= 0 + (*hbuff - '0');
        }

        if ((*hbuff >= 'A') && (*hbuff <= 'F')) {
            c |= 10 + (*hbuff - 'A');
        }
        
        *vbuff = c;

        hbuff++;
        vbuff++;
    }
}

// Convert byte buffer (vbuff argument) of len argument size into a hex
// string buffer (hbuff argument) into a ) 
static void val_to_hex_string(unsigned char *hbuff, unsigned char *vbuff, int len) {
    int i;

    for(i=0;i<len;i++) {
        if ((((*vbuff & 0xf0) >> 4) >= 0) && (((*vbuff & 0xf0) >> 4) <= 9)) {
            *hbuff = '0' + ((*vbuff & 0xf0) >> 4);
        }
        
        if ((((*vbuff & 0xf0) >> 4) >= 10) && (((*vbuff & 0xf0) >> 4) <= 15)) {
            *hbuff = 'A' + (((*vbuff & 0xf0) >> 4) - 10);
        }
        hbuff++;

        if (((*vbuff & 0x0f) >= 0) && ((*vbuff & 0x0f) <= 9)) {
            *hbuff = '0' + (*vbuff & 0x0f);
        }
        
        if (((*vbuff & 0x0f) >= 10) && ((*vbuff & 0x0f) <= 15)) {
            *hbuff = 'A' + ((*vbuff & 0x0f) - 10);
        }
        hbuff++;  
        vbuff++;
    }    
}

// Gets the length of an hex string coded in hbuff argument
static int hex_string_len(unsigned char *hbuff) {
    unsigned char c1;
    unsigned char c2;
    int len = 0;
    
    c1 = *hbuff++;
    c2 = *hbuff++;
    while ((c1 != '0') && (c2 != '0')) {
        len++;
        c1 = *hbuff++;
        c2 = *hbuff++;        
    }
    
    return len;
}

static int l_pack(lua_State *L) {
    int total = lua_gettop(L); // Number of arguments
    int i;                     // Current argument number
    unsigned char *pack;       // Packed string
    int data_idx;              // Current data index on pack string
    int header_len;            // Pack header length
    unsigned char *header;     // Header buffer
    unsigned char *cheader;    // Current position of header buffer

    // This variables are for store argument values
    unsigned char *luaStringVal;
    lua_Number luaNumberVal;
    lua_Integer luaIntegerVal;
    int luaBooleanVal;
    
    // Sanity checks
    if (total == 0) {
        return luaL_error(L, "missing arguments");
    }
    
    // Allocate space for header
    header_len = PACK_HEADER_LENGTH(total);
    header = (char *)malloc(header_len);
    if (!header) {
        return luaL_error(L, "not enough memory");
    }
    
    cheader = header;
    
    // Store number of packed elements in header
    *cheader = (char)total;

    // Get total argument size
    int argSize = 0;
    for(i=1; i <= total;i++) {
        switch(lua_type(L, i)) {
            case LUA_TNUMBER:
                if (lua_isinteger(L,i)) {
                    argSize += sizeof(lua_Integer);
                } else {
                    argSize += sizeof(lua_Number);                    
                }
                break;
                
            case LUA_TBOOLEAN:
                argSize += sizeof(unsigned char);
                break;

            case LUA_TSTRING:
                argSize += luaL_len(L, i) + 1;
                break;
        }
    }
    
    // Allocate space for pack string with enough space for encode the header,
    // encoded arguments and the end of string character
    pack = (char *)malloc((header_len + argSize) * 2 + 1);
    if (!pack) {
        free(header);
        return luaL_error(L, "not enough memory");
    }
    
    // Put index just before the end of header
    data_idx = header_len * 2;
    
    // Pack each element
    for(i=1; i <= total;i++) {
        if (((i-1) % PACK_TYPES_PER_BYTE) == 0) {
            cheader++;
            *cheader = 0;
        }
        
        switch(lua_type(L, i)) {
            case LUA_TNUMBER:
                if (lua_isinteger(L,i)) {
                    *cheader = *cheader | PACK_PACK_TYPE(PACK_INTEGER,i);                    

                    // Get value
                    luaIntegerVal = luaL_checkinteger(L, i);
                
                    // Encode value
                    val_to_hex_string(pack + data_idx, (unsigned char *)&luaIntegerVal, sizeof(lua_Integer));
                    data_idx = data_idx + (sizeof(lua_Integer) * 2);
                } else {
                    *cheader = *cheader | PACK_PACK_TYPE(PACK_NUMBER,i);                    
                    
                    // Get value
                    luaNumberVal = luaL_checknumber(L, i);
                
                    // Encode value
                    val_to_hex_string(pack + data_idx, (unsigned char *)&luaNumberVal, sizeof(lua_Number));
                    data_idx = data_idx + (sizeof(lua_Number) * 2);
                }
                
                *(pack + data_idx) = 0;                
                break;
                
            case LUA_TNIL:
                *cheader = *cheader | PACK_PACK_TYPE(PACK_NIL,i);
                *(pack + data_idx) = 0;                
                break;
                
            case LUA_TBOOLEAN:
                *cheader = *cheader | PACK_PACK_TYPE(PACK_BOOLEAN,i);

                // Get value
               luaBooleanVal = (unsigned char)lua_toboolean(L, i);
                 
                // Encode value
                val_to_hex_string(pack + data_idx, (unsigned char *)&luaBooleanVal, sizeof(char));
                data_idx = data_idx + (sizeof(char) * 2);
                *(pack + data_idx) = 0;                
                break;                

            case LUA_TSTRING:
                *cheader = *cheader | PACK_PACK_TYPE(PACK_STRING,i);

                // Get value
                luaStringVal = (unsigned char *)lua_tostring(L, i);
                
                // Encode value
                val_to_hex_string(pack + data_idx, luaStringVal, strlen(luaStringVal));
                data_idx = data_idx + (strlen(luaStringVal) * 2);
                *(pack + data_idx) = '0';data_idx++;
                *(pack + data_idx) = '0';data_idx++;
                *(pack + data_idx) = 0;
                break;  
            default:
                luaL_error(L, "unsupported type (argument %d)", i);break; 
        }
    }
    
    val_to_hex_string(pack, header, header_len);
    free(header);
    
    lua_pushstring(L, pack);
    free(pack);
    
    return 1;
}

static int l_unpack(lua_State *L) {
    int total;                   // Number of packet values
    int i;                       // Current packet value
    unsigned char *pack;         // Packed string
    int data_idx;                // Current data index on pack string
    unsigned char *header;       // Header buffer
    unsigned char *cheader;      // Current position of header buffer
    unsigned char headerv;       // Current header position buffer value
    unsigned char ctype;         // Current packet value type
    int slen;                    // For packet strings, it's length
    unsigned char unpack_first;  // If only first value must be unpack
    
    // This variables are for store argument values
    unsigned char *luaStringVal;
    lua_Number luaNumberVal;
    lua_Integer luaIntegerVal;
    char luaBooleanVal;

    if (lua_type(L, 1) == LUA_TNIL) {
        lua_pushnil(L);
        return 1;
    }
    
    // Get the packet string
    pack = (unsigned char *)luaL_checkstring(L, 1);

    // Check for an optional second argument, a boolean that tell if we want
    // to unpack only first value
    if (lua_type(L, 2) == LUA_TBOOLEAN) {
        unpack_first = lua_toboolean(L, 2);
    } else {
        unpack_first = 0;
    }

    // Init pointers
    header = pack;
    cheader = header;

    // Unpack number of arguments
    hex_string_to_val(cheader, &headerv, sizeof(unsigned char));
    total = headerv;

    // Put index just before the end of header
    data_idx = PACK_HEADER_LENGTH(total) * 2;

    // Unpack arguments ...
    for(i=1;i<=total;i++) {
        if (((i-1) % PACK_TYPES_PER_BYTE) == 0) {
            cheader += 2;
            
            // Unpack types
            hex_string_to_val(cheader, &headerv, sizeof(unsigned char));
        }
                
        ctype = PACK_UNPACK_TYPE(headerv, i);
        switch (ctype) {
            case PACK_NUMBER:
                // Unpack
                hex_string_to_val(pack + data_idx, (unsigned char *)&luaNumberVal, sizeof(lua_Number));
                data_idx += sizeof(lua_Number) * 2;                
                lua_pushnumber(L, luaNumberVal);
                break;
            case PACK_INTEGER:
                // Unpack
                hex_string_to_val(pack + data_idx, (unsigned char *)&luaIntegerVal, sizeof(lua_Integer));
                data_idx += sizeof(lua_Integer) * 2;
                lua_pushinteger(L, luaIntegerVal);
                break;
            case PACK_NIL:
                lua_pushnil(L);
                break;
            case PACK_BOOLEAN:
                // Unpack
                hex_string_to_val(pack + data_idx, (unsigned char *)&luaBooleanVal, sizeof(luaBooleanVal));
                data_idx += sizeof(luaBooleanVal) * 2;
                lua_pushboolean(L, luaBooleanVal);
                break;
            case PACK_STRING:
                // Get the string length
                slen = hex_string_len(pack + data_idx);
                
                // Allocate space for the string
                luaStringVal = (unsigned char *)malloc(slen + 1);
                if (!luaStringVal) {
                    return luaL_error(L, "not enough memory");
                }
                
                // Unpack
                hex_string_to_val(pack + data_idx, luaStringVal, slen);
                *(luaStringVal + slen) = 0;

                lua_pushstring(L, luaStringVal);
                
                free(luaStringVal);
                
                data_idx += slen * 2 + 2;
                break;
        }
    }
    
    free(pack);

    if (unpack_first) {
        if (total > 1) {
            lua_getglobal(L, "pack"); 
            lua_getfield(L, -1, "pack");
            lua_remove(L, -2);
            lua_copy(L, 3, 1);
            lua_copy(L, lua_gettop(L), 3);
            lua_remove(L, -1);
            lua_pcall(L, total - 1, 2, 0); 
            lua_remove(L, -1);
            lua_remove(L, -2);
        } else {
            lua_pushnil(L);
        }
        return 2;
    } else {
        return total;        
    }

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

#endif