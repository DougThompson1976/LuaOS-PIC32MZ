# pwm module
 
This module contains functions for accessing the CPU's UART.

In the whitecat you have up-to 6 UART modules, from 1 to 6.


## uart.setup(id, )

Setup the PWM module.

Arguments:

* id: PWM channel
* mode: setup mode, can be either pwm.DEFAULT or pwm.DAC

    For DEFAULT setup:

        * frequency: pulse frequency, expressed in kilohertz
        * initial duty: initial duty value, a decimal number beetween 0 and 1, 
where 0 is 0%, and 1 is 100%.

    For DAC setup:

        * resulution bits: the desired DAC resolution bits, for example 12.
        * initial value: initial value for the DAC, an integer number beetween 
0 and 2 ^ (resolution bits) - 1.

Returns: the real pulse frequency expressed in kilohertz.


```lua
-- Setup PWM's 3 channel at 10 Khz, with initial duty value of 50%.
freq = pwm.setup(led3, pwm.DEFAULT, 10, 0.5)
```


```lua
-- Setup PWM's 3 channel at 12 bit-resolution, with initial value of 2047.
-- This generate a voltage of 50% of the voltage reference in the related pin.
freq = pwm.setup(led3, pwm.DAC, 12, 2047)
```


## pwm.start(id)

Start the PWM channel.

Arguments:

id: PWM channel

Returns: nothing.


```lua
-- Setup PWM's 3 channel at 10 Khz, with initial duty value of 50%.
freq = pwm.setup(led3, pwm.DEFAULT, 10, 0.5)

-- Start PWM channel
pwm.start(3)
```


## pwm.stop(id)

Stop the PWM channel.
`
Arguments:

id: PWM channel

Returns: nothing.


```lua
-- Setup PWM's 3 channel al 10 Khz, with initial duty value of 50%.
freq = pwm.setup(led3, pwm.DEFAULT, 10, 0.5)


-- Do something with the PWM
....


-- Stop PWM channel
pwm.stop(3)
```


## pwm.setduty(id, value)

Set a new duty value. This function is only available if PWM channel is setup 
in DEFAULT mode.

Arguments:

* id: PWM channel
* value: new duty value, a decimal number beetween 0 and 1, 
where 0 is 0%, and 1 is 100%.

Returns: nothing.


```lua
-- Setup PWM's 3 channel at 10 Khz, with initial duty value of 50%.
freq = pwm.setup(led3, pwm.DEFAULT, 10, 0.5)

-- Start PWM channel
pwm.start(3)

-- Now duty value is 50%

-- Do something
....

-- Set new duty value (20%)
pwm.setduty(3, 0.2)

-- Do something
....

-- Stop PWM channel
pwm.stop(3)

```

## pwm.write(id, value)

Set a new value on the DAC. This function is only available if PWM channel is 
setup in DAC mode.

Arguments:

* id: PWM channel
* value: new value for the DAC, an integer number beetween 0 and 
2 ^ (resolution bits) - 1.

Returns: nothing.


```lua
-- Setup PWM's 3 channel at 12 bit-resolution, with initial value of 2047.
-- This generate a voltage of 50% of the voltage reference in the related pin.
freq = pwm.setup(led3, pwm.DAC, 12, 2047)

-- Start PWM channel
pwm.start(3)

-- Now duty value is 50%

-- Do something
....

-- Set new DAC value
pwm.write(3, 4095)

-- Do something
....

-- Stop PWM channel
pwm.stop(3)

```