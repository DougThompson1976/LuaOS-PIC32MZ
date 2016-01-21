-- system.lua
--
-- This script is executed after a system boot or a system reset and is intended
-- for setup the system. Once executed

---------------------------------------------------
-- Network
---------------------------------------------------

-- Start ethernet
-- net.start("en")

-- Start gprs
net.setup("gprs","m2m.vodafone.es","3267")
net.start("gprs")

-- Start sntp client
-- net.sntp()

---------------------------------------------------
-- Other setups
---------------------------------------------------
os.loglevel(os.LOG_ERROR)

os.logcons(false)        -- Enable/disable syslog messages to console
os.shell(true)           -- Enable/disable shell
os.history(true)         -- Enable/disable history
os.remove("/sd/history") -- Remove history