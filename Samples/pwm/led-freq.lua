-- WHITECAT sample code

-- Led is connected to this pwm
led_pwm = pwm.PWM7

-- Setup pwm at 10 Khz, initial duty is 0
pwm.setup(led_pwm, pwm.DEFAULT, 10000, 0)

-- Start pwm
pwm.start(led_pwm)

while true do
    -- Set duty from 0% to 100% at 10ms interval
    for duty = 0, 100 do
        pwm.setduty(led_pwm, duty / 100)
        tmr.delayms(10);
    end

    -- Set duty from 100% to 0% at 10ms interval
    for duty = 0, 100 do
        pwm.setduty(led_pwm, (100 - duty) / 100)
        tmr.delayms(10);
    end
end