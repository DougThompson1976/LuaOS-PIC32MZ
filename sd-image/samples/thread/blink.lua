-- WHITECAT sample code
--
-- Blink 2 leds in 2 threads

f1 = function()
    local led_pin = pio.PB_13
    pio.pin.setdir(pio.OUTPUT, led_pin)

    while true do
	pio.pin.sethigh(led_pin)
	tmr.delayms(250)
	pio.pin.setlow(led_pin)
	tmr.delayms(250)
    end
end

f2 = function()
    local led_pin = pio.PB_12
    pio.pin.setdir(pio.OUTPUT, led_pin)

    while true do
	pio.pin.sethigh(led_pin)
	tmr.delayms(50)
	pio.pin.setlow(led_pin)
	tmr.delayms(50)
    end
end

th1 = thread.start(f1)
th2 = thread.start(f2)
