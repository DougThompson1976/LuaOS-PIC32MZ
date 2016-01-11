-- WHITECAT sample code
--
-- Sample: mcp3208.lua
--
-- Description:
-- 
-- Reads analog value from MCP3208

-- Channel to read, and command for read this channel
channel = 0
command = 0x600 | (channel << 6)

-- Setup SPI as master, 1 Mhz speed, 8 bits
mcp3208 = spi.setup(spi.SPI4, spi.MASTER, pio.PE_4, 1000, 1, 1, 8)

-- Sample
i = 0
while i < 100000 do
    mcp3208:sson()
    val = mcp3208:readwrite(command >> 8, command, 0)
    mcp3208:ssoff()

    val = ((val[1] & 0x0f) << 8 | val[2])

    mval = (val * 3300) / 4095
   
    temp = (mval - 500) / 10

    print("SPI raw: "..val..", mv: "..mval..", temp: "..temp)

    tmr.delay(tmr.SYS_TIMER, 1 * tmr.SEC)

    i = i + 1
end

