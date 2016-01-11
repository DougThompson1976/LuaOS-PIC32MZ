-- WHITECAT sample code
--
-- Read adc value from a TMP36 temperature sensor and shows current temperature
-- value on an lcd every 2 seconds.

tmp36_adc = adc.ADC1   -- Sensor is connected to ADC1 module
tmp36_vref = adc.AVDD  -- ADC1 voltage reference to AVDD
tmp36_vrefv = 3200     -- ADC1 voltage reference to 3.3 volts
tmp36_chan = 0         -- Sensor is connected to ADC1 chan 0
tmp36_chan_res = 12    -- Channel resolution

-- Init LCD
screen.init("st7735", screen.OrientationH0)
screen.clear(screen.rgb(0,0,0))
screen.setfont("gohu-11")

-- Setup ADC module
adc1 = adc.setup(tmp36_adc, tmp36_vref, tmp36_vrefv)

-- Setup ADC channel
tmp36 = adc1:setupchan(tmp36_chan_res, tmp36_chan)

-- Take a sample every 2 seconds
while true do
    -- Read from adc
    val, mval = tmp36:read()

    -- Computes temperature
    temp = (mval - 500) / 10

    -- Show temperature
    screen.text(0,screen.height()/2,"TEMP: "..string.format("%.1f", temp))

    -- Wait
    tmr.delayms(2000)
end