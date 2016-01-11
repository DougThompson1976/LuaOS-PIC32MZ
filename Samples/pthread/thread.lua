temp = function()
    local tmp36_adc = adc.ADC1   -- Sensor is connected to ADC1 module
    local tmp36_vref = adc.AVDD  -- ADC1 voltage reference to AVDD
    local tmp36_vrefv = 3220     -- ADC1 voltage reference to 3.3 volts
    local tmp36_chan = 1         -- Sensor is connected to ADC1 chan 17
    local tmp36_chan_res = 12    -- Channel resolution

    local val = 0
    local mval = 0
    local temp = 0

    -- Setup ADC module
    local adc1 = adc.setup(tmp36_adc, tmp36_vref, tmp36_vrefv)

    -- Setup ADC channel
    local tmp36 = adc1:setupchan(tmp36_chan_res, tmp36_chan)

    while true do
        -- Read from adc
        val, mval = tmp36:read()

        -- Computes temperature
        temp = (mval - 500) / 10

        screen.text(0,0, string.format("%.0f ºC", temp))
        -- Wait
        tmr.delayms(1000)
    end
end

screen.init("st7735", screen.OrientationH0)
screen.clear(screen.rgb(0,0,0))
screen.setfont("gohu-11")

thread.start(temp)
