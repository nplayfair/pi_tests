#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

led1 = 0
led2 = 1

# Initialise LEDs
io1 = WiringPi::GPIO.new
io1.pin_mode(led1, WiringPi::PWM_OUTPUT)

io2 = WiringPi::GPIO.new
io2.pin_mode(led2, WiringPi::PWM_OUTPUT)

led1 = io1.soft_pwm_create 0, 0, 100
led2 = io2.soft_pwm_create 1, 0, 100

# Fading in

loop do
	for led_level in 0..100
	  io1.soft_pwm_write led1, led_level
	  sleep 0.002
	end

# Fading out

	for led_level in 0..100
	  io1.soft_pwm_write led1, 100 - led_level
	  sleep 0.002
	end
end
