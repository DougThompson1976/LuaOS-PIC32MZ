-- WHITECAT sample code
--
-- UART terminal

pio.pin.setdir(pio.OUTPUT,pio.PE_0)                                         
pio.pin.setlow(pio.PE_0)
tmr.delay(1)
pio.pin.sethigh(pio.PE_0)
tmr.delay(1)

line = ""
console = 1
uartid = 2

-- Setup UART, 57600 bps, 8N1
uart.setup(uartid, 57600, 8, uart.PARNONE, uart.STOP1)

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



net.setup("gprs","m2m.vodafone.es","3267")
net.start("gprs")
net.stop("gprs")
net.start("gprs")
gps.start()
gps.stop()


lora.setup()
lora.setAppEui("70B3D57ED0000187")
lora.setAppKey("CF584EAC0B9EB216379AF2FC7A9B4AB4")




mac set appeui 70B3D57ED0000412
mac set appkey AE07BD4621B7AAD81D5CAB3C5886BEEF
mac set adr on
mac save
mac join otaa

