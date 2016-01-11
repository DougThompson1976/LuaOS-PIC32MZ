-- WHITECAT sample code

-- Led is connected to this pwm
led_pwm = 3

-- Setup pwm at 8-bit resolution, and initial value 0
pwm.setup(led_pwm, pwm.DAC, 8, 0)

-- Start pwm
pwm.start(led_pwm)

while true do
    -- Set duty from 0 to 255 at 10ms interval
    for value = 0, 255 do
        pwm.write(led_pwm, value)
        tmr.delayms(10);
    end

    -- Set duty from 0 to 255 at 10ms interval
    for value = 0, 255 do
        pwm.write(led_pwm, 255 - value)
        tmr.delayms(10);
    end
end