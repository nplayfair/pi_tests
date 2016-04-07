#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

# Fade funcion
def fade

	# Setup Pins
	led1 = 0
	led2 = 1
	button_pin = 8
	fade_val = 0.003

	io1 = WiringPi::GPIO.new
	io1.pin_mode(led1, WiringPi::PWM_OUTPUT)

	io2 = WiringPi::GPIO.new
	io2.pin_mode(led2, WiringPi::PWM_OUTPUT)

	btn1 = WiringPi::GPIO.new
	btn1.pin_mode(button_pin, WiringPi::INPUT)

	led1 = io1.soft_pwm_create 0, 0, 100
	led2 = io2.soft_pwm_create 1, 100, 100
	
	# Wait for button to be pressed and fade LEDs
	
	loop do
	  state = btn1.digital_read button_pin
	  if state == 0
	    # Fade
	    for led_level in 0..100
	      io1.soft_pwm_write 0, led_level
	      io2.soft_pwm_write 1, 100 - led_level
	      sleep fade_val
	    end

	    for led_level in 0..100
	      io1.soft_pwm_write 0, 100 - led_level
	      io2.soft_pwm_write 1, led_level
	      sleep fade_val
	    end
	  end
	end
end

fade
