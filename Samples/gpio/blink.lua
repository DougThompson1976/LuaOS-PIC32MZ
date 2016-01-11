-- WHITECAT sample code
--
--  Blink a led every 250 msecs

led_pin = pio.PB_13
pio.pin.setdir(pio.OUTPUT, led_pin)

while true do
    pio.pin.sethigh(led_pin)
    tmr.delayms(250)
    pio.pin.setlow(led_pin)
    tmr.delayms(250)
end