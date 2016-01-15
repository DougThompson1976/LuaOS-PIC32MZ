-- WHITECAT sample code
--
--  Moves a servo

pio.pin.setdir(pio.OUTPUT, pio.PB_0)

function setServo(micros, milis)
    start = os.clock()
	
    while ((os.clock() - start) * 1000 < milis) do
        pio.pin.sethigh(pio.PB_0)
        tmr.delayus(micros)
        pio.pin.setlow(pio.PB_0)
        tmr.delayus(20000-micros)
    end
end

// Moves servo first in clockwise direction and then in counter-clockwise
while true do
    setServo(1800,1500)
    setServo(1200,1500)
end