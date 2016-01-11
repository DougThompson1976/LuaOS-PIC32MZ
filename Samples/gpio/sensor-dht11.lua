-- WHITECAT sample code
--
-- Sample: 
--
-- Description:
--   ....

dht11_pin = pio.PE_5

pio.pin.setdir(pio.OUTPUT, dht11_pin)

pio.pin.setlow(dht11_pin)
tmr.delay(tmr.SYS_TIMER, tmr.MSEC * 20)

pio.pin.sethigh(dht11_pin)
pio.pin.setpull(pio.PULLUP,dht11_pin)
tmr.delay(tmr.SYS_TIMER, 40)

pio.pin.setdir(pio.INPUT, dht11_pin)

while pio.pin.getval(dht11_pin) == 1 do
end


