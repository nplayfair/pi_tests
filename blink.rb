#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi'

# New GPIO obj
gpio = WiringPi::GPIO.new

# Pin names
led = 1

# Pin mode
gpio.mode led, OUTPUT

# Flashing loop

loop do
	puts "loop..."
	sleep 1
	gpio.write led, 1
	sleep 1
	gpio.write led, 0
end
