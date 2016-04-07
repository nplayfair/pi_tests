#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

# Setup Pins
led_pins = [0, 1]
button_pin = 8
fade_val = 0.003

# Instantiate GPIO object
io = WiringPi::GPIO.new

io.pin_mode button_pin, WiringPi::INPUT
led_pins.each do |pin|
	io.pin_mode pin, WiringPi::PWM_OUTPUT
end

# Set parameters
led[0] = io.soft_pwm_create led_pins[0], 0, 100
led[1] = io.soft_pwm_create led_pins[1], 100, 100

# Fade funcion
def fade

  # io1 = WiringPi::GPIO.new
  # io1.pin_mode(led1, WiringPi::PWM_OUTPUT)

  # io2 = WiringPi::GPIO.new
  # io2.pin_mode(led2, WiringPi::PWM_OUTPUT)

  # btn1 = WiringPi::GPIO.new
  # btn1.pin_mode(button_pin, WiringPi::INPUT)

  # led1 = io1.soft_pwm_create 0, 0, 100
  # led2 = io2.soft_pwm_create 1, 100, 100
  
  # Wait for button to be pressed and fade LEDs
  
  loop do
    state = io.digital_read button_pin
    if state == 0
      # Fade
      for led_level in 0..100
        io.soft_pwm_write 0, led_level
        io.soft_pwm_write 1, 100 - led_level
        sleep fade_val
      end

      for led_level in 0..100
        io.soft_pwm_write 0, 100 - led_level
        io.soft_pwm_write 1, led_level
        sleep fade_val
      end
    end
  end
end

fade
