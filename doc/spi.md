# SPI module

This module contains functions for accessing the analog to SPI module.

The whitecat has up to 4 modules. Each module is identied by one of this 
constants spi.SPI1, spi.SPI2, spi.SPI3, spi.SPI4.

SPI module can work in master or slave mode, each of then identified by 
spi.MASTER and spi.SLAVE constants.

mcp3208 = spi.setup(spi.SPI1, spi.MASTER, pio.PE_4, 1000000, 1, 1, 8)


## spi = spi.setup(id, mode, cs, speed, polarity, phase, data bits)

Setup the SPI module.

Arguments:

* id: SPI module identifier. Use spi.SPI1, spi.SPI2, spi.SPI3 or spi.SPI4.
* mode: SPI mode, can either spi.MASTER or spi.SLAVE.
* speed: speed of the spi module, expressed in kilohertz.
* polarity: clock polarity (0 or 1)
* phase: clock phase (0 or 1)
* data bits: can be either, 8, 16 or 32 bits.

Returns: an spi instance. You must store this instance into a variable for
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