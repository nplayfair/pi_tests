#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

led = 1

# New GPIO obj
io = WiringPi::GPIO.new do |gpio|
	gpio.pin_mode(led, WiringPi::PWM_OUTPUT)
end

# Fading in

loop do
	for led_level in 0..1023
	  io.pwmWrite led, led_level
	  sleep 0.002
	end

# Fading out

	for led_level in 0..1023
	  io.pwmWrite led, 1023 - led_level
	  sleep 0.002
	end
end
