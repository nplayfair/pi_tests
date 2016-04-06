#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

led = 0

# New GPIO obj
io = WiringPi::GPIO.new do |gpio|
	gpio.pin_mode(led, WiringPi::OUTPUT)
end

# Flashing loop

loop do
	sleep 1
	io.digital_write led, 1
	sleep 1
	io.digital_write led, 0
end
