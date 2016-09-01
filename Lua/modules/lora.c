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

#include "whitecat.h"

#if LUA_USE_LORA

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#include <drivers/cpu/error.h>
#include <drivers/lora/lora.h>

static int rx_callback = 0;
static lua_State* rx_callbackL;

static void on_received(int port, char *payload) {
    if (rx_callback != LUA_NOREF) {
        lua_rawgeti(rx_callbackL, LUA_REGISTRYINDEX, rx_callback);
        lua_pushinteger(rx_callbackL, port);
        lua_pushlstring(rx_callbackL, payload, strlen(payload));
        lua_call(rx_callbackL, 2, 0);
    }
    
    free(payload);
}

static void lora_error(lua_State* L, int code) {
    switch (code){
        case LORA_KEYS_NOT_CONFIGURED:
            luaL_error(L, "%d:keys are not configured", LORA_KEYS_NOT_CONFIGURED);break;
        case LORA_ALL_CHANNELS_BUSY:
            luaL_error(L, "%d:all channels are busy", LORA_ALL_CHANNELS_BUSY);break;
        case LORA_DEVICE_IN_SILENT_STATE:
            luaL_error(L, "%d:device is in silent state", LORA_DEVICE_IN_SILENT_STATE);break;
        case LORA_DEVICE_DEVICE_IS_NOT_IDLE:
            luaL_error(L, "%d:device is not idle", LORA_DEVICE_DEVICE_IS_NOT_IDLE);break;
        case LORA_PAUSED:
            luaL_error(L, "%d:lora stack are paused", LORA_PAUSED);break;
        case LORA_TIMEOUT:
            luaL_error(L, "%d:time out", LORA_TIMEOUT);break;
        case LORA_JOIN_DENIED:
            luaL_error(L, "%d:join denied", LORA_JOIN_DENIED);break;
        case LORA_UNEXPECTED_RESPONSE:
            luaL_error(L, "%d:unexpected response", LORA_UNEXPECTED_RESPONSE);break;
        case LORA_NOT_JOINED:
            luaL_error(L, "%d:not joined", LORA_NOT_JOINED);break;
        case LORA_REJOIN_NEEDED:
            luaL_error(L, "%d:rejoin needed", LORA_REJOIN_NEEDED);break;
        case LORA_INVALID_DATA_LEN:
            luaL_error(L, "%d:invalid data len", LORA_INVALID_DATA_LEN);break;
        case LORA_TRANSMISSION_FAIL_ACK_NOT_RECEIVED:
            luaL_error(L, "%d:transmission fail, ack not received", LORA_TRANSMISSION_FAIL_ACK_NOT_RECEIVED);break;
        case LORA_NOT_SETUP:
            luaL_error(L, "%d:lora is not setup, setup first", LORA_NOT_SETUP);break;
        case LORA_INVALID_PARAM:
            luaL_error(L, "%d:invalid argument", LORA_INVALID_ARGUMENT);break;
    }
}

// Checks if passed strings represents a valid hex number
static int check_hex_str(const char *str) {
    while (*str) {
        if (((*str < '0') || (*str > '9')) && ((*str < 'A') || (*str > 'F'))) {
            return 0;
        }

        str++;
    }
    
    return 1;
}

// Pads a hex number string representation at a specified length
static char *hex_str_pad(lua_State* L, const char  *str, int len) {
    if (!check_hex_str(str)) {
        luaL_error(L, "invalid hexadecimal number");     
    }
    
    // Allocate string
    char *tmp = (char *)malloc(len + 1);
    if (!tmp) {
        luaL_error(L, "not enough memory");
    }

    if (strlen(str) < len) {
        // Needs pad
        int i;
        int curr_len = strlen(str);
        int pad_num = len - curr_len;
        char *c = tmp;
        
        // Pad with 0
        for(i=0;i < pad_num;i++) {
            *c++ = '0';
        }

       // Copy rest of string
        for(i = pad_num - 1;i < len; i++) {
            *c++ = *str++;
        }
        
        *c = 0x00;
    } else {
        strcpy(tmp, str);
    }

    return tmp;
}

static int llora_setup(lua_State* L) {    
    tdriver_error *error;
    
    int band = luaL_optinteger(L, 1, 868);
    
    luaL_checktype(L, 2, LUA_TBOOLEAN);
    
    int rx_listener = lua_toboolean( L, 2 );

    // Sanity checks
    if ((band != 868) && (band != 433)) {
        return luaL_error(L, "%d:invalid band", LORA_INVALID_ARGUMENT);
    }
    
    // Setup in base of frequency
    error = lora_setup(band, rx_listener);
    if (error) {
        return luaL_driver_error(L, "lora can't setup", error);
    }
    
    return 0;
}

static int llora_set_setDevAddr(lua_State* L) {
    char *devAddr = hex_str_pad(L, luaL_checkstring(L, 1), 8);
    
    int resp = lora_mac_set("devaddr", devAddr);
    if (resp != LORA_OK) {
        free(devAddr);
        lora_error(L, resp);    
    }
    
    free(devAddr);
    return 0;    
}

static int llora_set_DevEui(lua_State* L) {
    char  *devEui = hex_str_pad(L, luaL_checkstring(L, 1), 16);
        
    int resp = lora_mac_set("deveui", devEui);
    if (resp != LORA_OK) {
        free(devEui);
        lora_error(L, resp);    
    }
    
    free(devEui);
    return 0;  
}

static int llora_set_AppEui(lua_State* L) {
    char  *appEui = hex_str_pad(L, luaL_checkstring(L, 1), 16);
        
    int resp = lora_mac_set("appeui", appEui);
    if (resp != LORA_OK) {
        free(appEui);
        lora_error(L, resp);    
    }

    free(appEui);
    return 0;  
}

static int llora_set_NwkSKey(lua_State* L) {
    char  *nwkSKey = hex_str_pad(L, luaL_checkstring(L, 1), 32);
        
    int resp = lora_mac_set("nwkskey", nwkSKey);
    if (resp != LORA_OK) {
        free(nwkSKey);
        lora_error(L, resp);    
    }
    
    free(nwkSKey);
    return 0;  
}

static int llora_set_AppSKey(lua_State* L) {
    char  *appSKey = hex_str_pad(L, luaL_checkstring(L, 1), 32);
        
    int resp = lora_mac_set("appsKey", appSKey);
    if (resp != LORA_OK) {
        free(appSKey);
        lora_error(L, resp);    
    }

    free(appSKey);
    return 0;
}

static int llora_set_AppKey(lua_State* L) {
    char  *appKey = hex_str_pad(L, luaL_checkstring(L, 1), 32);
        
    int resp = lora_mac_set("appkey", appKey);
    if (resp != LORA_OK) {
        free(appKey);
        lora_error(L, resp);    
    }

    free(appKey);
    return 0;
}

static int llora_set_Dr(lua_State* L) {
    int dr = luaL_checkinteger(L, 1);
    
    if ((dr < 0) || (dr > 7)) {
        return luaL_error(L, "%d:invalid data rate value (0 to 7)", LORA_INVALID_ARGUMENT); 
    }
    
    char value[2];
    
    sprintf(value,"%d", dr);
        
    int resp = lora_mac_set("dr", value);
    if (resp != LORA_OK) {
        lora_error(L, resp);    
    }

    return 0;
}

static int llora_set_Adr(lua_State* L) {
    char value[4];

    luaL_checktype(L, 1, LUA_TBOOLEAN);
    if (lua_toboolean( L, 1 )) {
        strcpy(value, "on");
    } else {
        strcpy(value, "off");
    }
    
    int resp = lora_mac_set("adr", value);
    if (resp != LORA_OK) {
        lora_error(L, resp);    
    }

    return 0;
}

static int llora_set_RetX(lua_State* L) {
    int rets = luaL_checkinteger(L, 1);
    
    if ((rets < 0) || (rets > 255)) {
        return luaL_error(L, "%d:invalid retransmissions value (0 to 255)", LORA_INVALID_ARGUMENT); 
    }
    
    char value[2];
    
    sprintf(value,"%d", rets);
        
    int resp = lora_mac_set("retx", value);
    if (resp != LORA_OK) {
        lora_error(L, resp);    
    }

    return 0;
}

static int llora_set_Ar(lua_State* L) {
    char value[4];

    luaL_checktype(L, 1, LUA_TBOOLEAN);
    if (lua_toboolean( L, 1 )) {
        strcpy(value, "on");
    } else {
        strcpy(value, "off");
    }
    
    int resp = lora_mac_set("ar", value);
    if (resp != LORA_OK) {
        lora_error(L, resp);    
    }
    
    return 0;
}


static int llora_set_LinkChk(lua_State* L) {
    int interval = luaL_checkinteger(L, 1);
    
    if ((interval < 0) || (interval > 65535)) {
        return luaL_error(L, "%d:invalid interval (0 to 65535)", LORA_INVALID_ARGUMENT); 
    }
    
    char value[6];
    
    sprintf(value,"%d", interval);
        
    int resp = lora_mac_set("linkchk", value);
    if (resp != LORA_OK) {
        lora_error(L, resp);    
    }

    return 0;
}

static int llora_get_DevAddr(lua_State* L) {
    char *value = lora_mac_get("devaddr");
    
    lua_pushlstring(L, value, strlen(value));
    free(value);
    
    return 1;    
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

static int llora_get_Dr(lua_State* L) {
    char *value = lora_mac_get("dr");
    
    lua_pushinteger(L, atoi(value));
    free(value);
    
    return 1;    
}

static int llora_get_Adr(lua_State* L) {
    char *value = lora_mac_get("adr");
    
    if (strcmp(value,"on") == 0) {
        lua_pushboolean(L, 1);
    } else {
        lua_pushboolean(L, 0);        
    }

    free(value);
    
    return 1;    
}

static int llora_get_RetX(lua_State* L) {
    char *value = lora_mac_get("retx");
    
    lua_pushinteger(L, atoi(value));
    free(value);
    
    return 1;    
}

static int llora_get_Ar(lua_State* L) {
    char *value = lora_mac_get("ar");
    
    if (strcmp(value,"on") == 0) {
        lua_pushboolean(L, 1);
    } else {
        lua_pushboolean(L, 0);        
    }

    free(value);
    
    return 1;    
}

static int llora_get_Mrgn(lua_State* L) {
    char *value = lora_mac_get("mrgn");
    
    lua_pushinteger(L, atoi(value));
    free(value);
    
    return 1;    
}

static int llora_join(lua_State* L) {
    int resp = 0;
    
    int join_type = luaL_checkinteger(L, 1);

    if ((join_type != 1) && (join_type != 2)) {
        return luaL_error(L, "%d:invalid join type, user lora.OTAA or lora.ABP", LORA_INVALID_ARGUMENT);                
    }
    
    if (join_type == 2) {
        return luaL_error(L, "%d:ABP not allowed", LORA_INVALID_ARGUMENT);                
    }
    
    if (join_type == 1)
        resp = lora_join_otaa();
    
    if (resp != LORA_OK) {
        lora_error(L, resp);
    }
    
    return 0;
}

static int llora_tx(lua_State* L) {
    luaL_checktype(L, 1, LUA_TBOOLEAN);
    int cnf = lua_toboolean( L, 1 );
    int port = luaL_checkinteger(L, 2);
    const char *data = luaL_checkstring(L, 3);
    
    if ((port < 1) || (port > 223)) {
        return luaL_error(L, "%d:invalid port number", LORA_INVALID_ARGUMENT);   
    }

    if (!check_hex_str(data)) {
        luaL_error(L, "%d:invalid data", LORA_INVALID_ARGUMENT);     
    }    
    
    int resp = lora_tx(cnf, port, data);
    if (resp != LORA_OK) {
        lora_error(L, resp);
    }
    
    return 0;    
}

static int llora_rx(lua_State* L) {
    luaL_checktype(L, 1, LUA_TFUNCTION);
    lua_pushvalue(L, 1); 

    rx_callback = luaL_ref(L, LUA_REGISTRYINDEX);
            
    rx_callbackL = L;
    lora_set_rx_callback(on_received);
    
    return 0;
}

static int llora_nothing(lua_State* L) {
    return luaL_error(L, "%d:not implemented", LORA_INVALID_ARGUMENT);    
}

static const luaL_Reg lora[] = {
    {"setup",        llora_setup}, 
    {"setDevAddr",   llora_set_setDevAddr}, 
    {"setDevEui" ,   llora_set_DevEui}, 
    {"setAppEui" ,   llora_set_AppEui}, 
    {"setAppKey" ,   llora_set_AppKey}, 
    {"setNwksKey",   llora_set_NwkSKey}, 
    {"setAppsKey",   llora_set_AppSKey}, 
    {"setAppKey",    llora_set_AppKey}, 
    {"setDr",        llora_set_Dr}, 
    {"setAdr",       llora_set_Adr}, 
    {"setRetX",      llora_set_RetX}, 
    {"setLinkChk",   llora_set_LinkChk}, // MUST DO
    {"setRxDelay1",  llora_nothing}, 
    {"setAr",        llora_set_Ar}, 
    {"setRx2",       llora_nothing}, // MUST DO
    {"setChFreq",    llora_nothing}, // MUST DO
    {"setChFCycle",  llora_nothing}, 
    {"setChDrrange", llora_nothing}, // MUST DO
    {"setChStatus",  llora_nothing}, 
    {"getDevAddr",   llora_get_DevAddr}, 
    {"getDevEui" ,   llora_get_DevEui}, 
    {"getAppEui" ,   llora_get_AppEui}, 
    {"getDr",        llora_get_Dr}, 
    {"getAdr",       llora_get_Adr}, 
    {"getRetX",      llora_get_RetX}, 
    {"getRxDelay1",  llora_nothing}, 
    {"getRxDelay2",  llora_nothing},
    {"getAr",        llora_get_Ar}, 
    {"getRx2",       llora_nothing}, 
    {"getDCyclePs",  llora_nothing}, 
    {"getMrgn",      llora_get_Mrgn}, 
    {"getGwNb",      llora_nothing}, 
    {"getStatus",    llora_nothing}, 
    {"getCha",       llora_nothing}, 
    {"join",         llora_join}, 
    {"tx",           llora_tx},
    {"whenReceived", llora_rx},
    {NULL, NULL}
};

int luaopen_lora(lua_State* L) {
    luaL_newlib(L, lora);

    lua_pushinteger(L, 868);
    lua_setfield(L, -2, "BAND868");

    lua_pushinteger(L, 433);
    lua_setfield(L, -2, "BAND433");

    lua_pushinteger(L, 1);
    lua_setfield(L, -2, "OTAA");
    
    lua_pushinteger(L, 2);
    lua_setfield(L, -2, "ABP");

    // Create a table of errors
    lua_newtable(L);
    
    lua_pushinteger(L, LORA_KEYS_NOT_CONFIGURED);
    lua_setfield(L, -2, "KeysNotConfigured");
    
    lua_pushinteger(L, LORA_ALL_CHANNELS_BUSY);
    lua_setfield(L, -2, "AllChannelsBusy");

    lua_pushinteger(L, LORA_DEVICE_IN_SILENT_STATE);
    lua_setfield(L, -2, "DeviceInSilentState");

    lua_pushinteger(L, LORA_DEVICE_DEVICE_IS_NOT_IDLE);
    lua_setfield(L, -2, "DeviceIsNotIdle");

    lua_pushinteger(L, LORA_PAUSED);
    lua_setfield(L, -2, "Paused");

    lua_pushinteger(L, LORA_TIMEOUT);
    lua_setfield(L, -2, "Timeout");

    lua_pushinteger(L, LORA_JOIN_DENIED);
    lua_setfield(L, -2, "JoinDenied");

    lua_pushinteger(L, LORA_UNEXPECTED_RESPONSE);
    lua_setfield(L, -2, "UnexpectedResponse");

    lua_pushinteger(L, LORA_NOT_JOINED);
    lua_setfield(L, -2, "NotJoined");

    lua_pushinteger(L, LORA_REJOIN_NEEDED);
    lua_setfield(L, -2, "RejoinNeeded");

    lua_pushinteger(L, LORA_INVALID_DATA_LEN);
    lua_setfield(L, -2, "InvalidDataLen");

    lua_pushinteger(L, LORA_TRANSMISSION_FAIL_ACK_NOT_RECEIVED);
    lua_setfield(L, -2, "TransmissionFail");

    lua_pushinteger(L, LORA_NOT_SETUP);
    lua_setfield(L, -2, "NotSetup");

    lua_pushinteger(L, LORA_INVALID_PARAM);
    lua_setfield(L, -2, "InvalidArgument");

    lua_setfield(L, -2, "error");

    return 1;
}

#endif