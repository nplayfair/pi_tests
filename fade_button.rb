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
led[0] = io.soft_pwm_create LED_PINS[0], 0, 100
led[1] = io.soft_pwm_create LED_PINS[1], 100, 100

# Fade funcion
def fade (io)

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
