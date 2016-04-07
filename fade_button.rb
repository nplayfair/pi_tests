#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

# Setup Pins
LED_PINS = [0, 1, 2]
BUTTON_PIN = 8
FADE_VAL = 0.005

# Instantiate GPIO object
io = WiringPi::GPIO.new

io.pin_mode BUTTON_PIN, WiringPi::INPUT
LED_PINS.each do |pin|
	io.pin_mode pin, WiringPi::PWM_OUTPUT
end

# Set parameters
LED_PINS.each do |led|
  #io.soft_pwm_create led, 100, 100 if led == 0
  #puts "#{led} \n"
  io.soft_pwm_create led, 0, 100
end

# Fade funcion
def fade (io)

# Vars
led_count = LED_PINS.length
on_led = 0

# Wait for button to be pressed and fade LEDs
  loop do
    state = io.digital_read BUTTON_PIN
    if state == 0 # Run the routine
      led_count.times do |cycle|
        # Fade on
        for led_level in 0..100
          led_count.times do |led|
            io.soft_pwm_write on_led, 100 - led_level # dim on_led
            io.soft_pwm_write on_led + 1, led_level # brighten next led 
            sleep FADE_VAL
          end
        end
        on_led = cycle
      end
    end
  end
end

fade io
