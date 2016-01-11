# ADC module

This module contains functions for accessing the analog to digital converter 
(ADC) module.

The whitecat has up to 6 on-board dedicated ADC circuits and 1 on-board shared 
ADC circuit. The dedicated circuits uses a single input and is intended for 
high-speed and precise sampling of time-sensitive or transient inputs, whereas 
the shared circuit incorporates a multiplexer on the input to facilitate a 
larger group of inputs, with slower sampling.

The assignment to one of the dedicated or shared circuits is transparent to the 
programmer and depends on the used ADC input.

All on-board ADC circuits are identified with the adc.ADC1 module constant. More
 ADC can be added to the whitecat through specific ADC shields, each of them
identified by adc.ADC2, adc.ADC3 and so on.


## adc = adc.setup(id, vref, vrefv)

Setup the ADC module.

Arguments:

* id: ADC module identifier. Use adc.ADC1 for on-board module
* vref: voltage reference. Only adc.AVDD is allowed in this version
* vrefv: voltage reference value, in millivolts

Returns: an ADC instance. You must store this instance into a variable for
further operations with it.

```lua
-- Setup on-board ADC module, using AVDD as voltage reference. Voltage reference
-- value is 3.3 V (3300 millivolts)

adc1 = adc.setup(adc.ADC1, adc.AVDD, 3300)
```


## channel = instance:setupchan(resolution, input)

Setup an ADC input channel.

Arguments:

* resolution: resolution to use, can be either 12, 10, 8 or 6 bits 
* input: ADC input channel

Returns: an ADC channel instance. You must store this instance into a variable 
for further operations with it.

```lua
-- Setup ADC input channel 0 to 12-bit resolution

channel = adc1:setupchan(12, 0)
```


## raw, millivolts = instance:read()

Read the channel instance ADC value.

Returns:

* raw: raw value
* millivolts: raw value converted to millivolts 


## Example: read temperature from a TMP36 sensor

```lua
-- Read adc value from a TMP36 temperature sensor and shows current temperature
-- value on the screen.

tmp36_adc = adc.ADC1   -- Sensor is connected to ADC1 module
tmp36_vref = adc.AVDD  -- ADC1 voltage reference to AVDD
tmp36_vrefv = 3300     -- ADC1 voltage reference to 3.3 volts
tmp36_chan = 0         -- Sensor is connected to ADC1 chan 0
tmp36_chan_res = 12    -- Channel resolution

-- Setup ADC module
adc1 = adc.setup(tmp36_adc, tmp36_vref, tmp36_vrefv)

-- Setup ADC channel
tmp36 = adc1:setupchan(tmp36_chan_res, tmp36_chan)

-- Sample
while true do
    -- Read from adc
    val, mval = tmp36:read()

    -- Computes temperature
    temp = (mval - 500) / 10

    -- Show temperature
    print("raw: "..val.."\t mvolts: "..mval.."\t temp: "..string.format("%.2f", temp))

    -- Wait
    tmr.delay(tmr.SYS_TIMER, 1 * tmr.SEC)
end
```