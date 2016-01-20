-- system.lua
--
-- This script is executed after a system boot or a system reset and is intended
-- for setup the system. Once executed

----------------------------------------
-- Network
----------------------------------------

-- Start ethernet
-- net.start("en")

-- Start gprs
net.setup("gprs","m2m.vodafone.es","3267")
net.start("gprs")

-- Start sntp client
-- net.sntp()

----------------------------------------
-- Other setups
----------------------------------------
shell(true)              -- Enable shell
history(true)            -- Enable history
os.remove("/sd/history") -- Remove history