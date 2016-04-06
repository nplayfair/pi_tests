#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

led = 1

# New GPIO obj
io = WiringPi::GPIO.new
io.pin_mode(led, WiringPi::PWM_OUTPUT)

led = io.soft_pwm_create 0, 0, 100

# Fading in

loop do
	for led_level in 0..100
	  io.soft_pwm_write led, led_level
	  sleep 0.002
	end

# Fading out

	for led_level in 0..100
	  io.soft_pwm_write led, 100 - led_level
	  sleep 0.002
	end
end
