#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

# Setup Pins
LED_PINS = [0, 1]
BUTTON_PIN = 8
FADE_VAL = 0.003
led = Array.new

# Instantiate GPIO object
io = WiringPi::GPIO.new

io.pin_mode BUTTON_PIN, WiringPi::INPUT
LED_PINS.each do |pin|
	io.pin_mode pin, WiringPi::PWM_OUTPUT
end

# Set parameters
io.soft_pwm_create LED_PINS[0], 0, 100
io.soft_pwm_create LED_PINS[1], 100, 100

# Fade funcion
def fade (io)

# Wait for button to be pressed and fade LEDs
  
  loop do
    state = io.digital_read BUTTON_PIN
    if state == 0
      # Fade
      for led_level in 0..100
        io.soft_pwm_write 0, led_level
        io.soft_pwm_write 1, 100 - led_level
        sleep FADE_VAL
      end

      for led_level in 0..100
        io.soft_pwm_write 0, 100 - led_level
        io.soft_pwm_write 1, led_level
        sleep FADE_VAL
      end
    end
  end
end

fade io
