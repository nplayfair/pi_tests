#!/usr/bin/env ruby

require 'rubygems'
require 'wiringpi2'

# Setup Pins
LED_PINS = [0, 1, 2]
BUTTON_PIN = 8
FADE_VAL = 0.003

# Instantiate GPIO object
io = WiringPi::GPIO.new

io.pin_mode BUTTON_PIN, WiringPi::INPUT
LED_PINS.each do |pin|
	io.pin_mode pin, WiringPi::PWM_OUTPUT
end

# Set parameters
LED_PINS.each do |led|
  io.soft_pwm_create led, 0, 100
end

## Fade on
def fade_on (io = io, led)
  for led_level in 0..100
    io.soft_pwm_write led, led_level
    sleep FADE_VAL
  end
end

## Fade off
def fade_off (io = io, led)
  for led_level in 0..100
    io.soft_pwm_write led, 100 - led_level
    sleep FADE_VAL
  end
end

## Fade funcion
def fade (io)

# Vars
led_count = LED_PINS.length
state = 1
on_led = 0

# Wait for button to be pressed and fade LEDs
  loop do
    state = io.digital_read BUTTON_PIN
    if state == 0 # Run the routine
      # Fade first LED on
      for led_level in 0..100
        io.soft_pwm_write on_led, led_level
      end
      # Iterate through all LEDs  
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
        puts "#{cycle} \n"
      end # end cycle
      # Fade last one out
      for led_level in 0..100
        io.soft_pwm_write on_led, 100 - led_level
      end
      puts "turn last off\n"
    end # end if
  end # end loop
end # end method

#fade io
fade_on io, 0
fade_off io, 0
fade_on io, 1
fade_off io, 1 
fade_on io, 2
fade_off io, 2 
