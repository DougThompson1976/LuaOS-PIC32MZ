-- WHITECAT sample code
--
--  Moves a servo

pio.pin.setdir(pio.OUTPUT, pio.PD_10)

function setServo(micros, milis)
    start = os.clock()
	
    while ((os.clock() - start) * 1000 < milis) do
        pio.pin.sethigh(pio.PD_10)
        tmr.delayus(5)
        pio.pin.setlow(pio.PD_10)
        tmr.delayus(5)
    end
end

while true do
        pio.pin.sethigh(pio.PD_10)
        tmr.delayus(100)
        pio.pin.setlow(pio.PD_10)
        tmr.delayus(100)
end