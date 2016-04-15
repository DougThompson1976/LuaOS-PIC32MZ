#include <drivers/error.h>
#include <drivers/cpu/cpu.h>
#include <drivers/cpu/resource.h>

#include <Lua/src/lstate.h>

int luaL_driver_error(lua_State* L, const char *msg, tdriver_error *error) {
    tdriver_error err;
    int ret_val;
    
    if (error->type == LOCK) {
        if (error->resource_unit == -1) {
            ret_val = luaL_error(L,
                "%s: no %s available", 
                msg,
                resource_name(error->resource)
            );                        
        } else {
            ret_val = luaL_error(L,
                "%s: %s is used by %s%d", 
                msg,
                resource_unit_name(error->resource, error->resource_unit),
                owner_name(error->owner),
                error->owner_unit + 1
            );            
        }
        
        return ret_val;
    }
    
    return luaL_error(L, msg);
}