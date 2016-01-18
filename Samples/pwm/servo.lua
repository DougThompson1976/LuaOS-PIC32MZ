-- WHITECAT sample code
--
-- Move 2 servos
--
-- SERVO1: PB2
-- SERVO2: PB5

-- freq = 1 / T 
--
-- freq = 1 / 20 * 10^-3 = 50 hz
--
-- 1200 = duty time of 6%
-- 1800 = duty time of 8%
-- 1500 = duty time of 7.5%

direction = {
	clockwise = 0.06,
	cclockwise = 0.08,
	stop = 0.075
}

servo1_pwm = pwm.PWM1
servo2_pwm = pwm.PWM3

pwm.setup(servo1_pwm, pwm.DEFAULT, 50, direction.stop)
pwm.start(servo1_pwm)

pwm.setup(servo2_pwm, pwm.DEFAULT, 50, direction.stop)
pwm.start(servo2_pwm)

-- Wait for some event and change direction
pwm.setduty(servo1_pwm, direction.cclockwise)

-- Wait for some event and change direction
pwm.setduty(servo2_pwm, direction.cclockwise)

