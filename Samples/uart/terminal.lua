-- WHITECAT sample code
--
-- UART terminal

line = ""
console = 1
uartid = 3

-- Setup UART, 115200 bps, 8N1
uart.setup(uartid, 115200, 8, uart.PARNONE, uart.STOP1)

while true do
    -- Read from console
    c = uart.read(console, "*c", 0)
    if (c) then
        -- Echo to console
        uart.write(console, c)
        if (string.char(c) == '\r') then
            uart.write(console, '\n')
        end

        -- Write to serial port
        uart.write(uartid, c)

        if (string.char(c) == '\r') then
            uart.write(uartid, '\n')
        end
    end

    -- Read from serial port
    c = uart.read(uartid, "*c", 0)
    if (c) then
        uart.write(console, c)
    end
end


while true do
net.setup("gprs","m2m.vodafone.es","3267")
net.start("gprs")
tmr.delayms(10000)
net.stop("gprs")
tmr.delayms(10000)
end