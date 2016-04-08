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
def fade_on (io, led)
  for led_level in 0..100
    io.soft_pwm_write led, led_level
    sleep FADE_VAL
  end
end

## Fade off
def fade_off (io, led)
  for led_level in 0..100
    io.soft_pwm_write led, 100 - led_level
    sleep FADE_VAL
  end
end

## Fade pair

def fade_pair (io, led1, led2, fade_value = FADE_VAL)
  for led_level in 0..100
    io.soft_pwm_write led1, 100 - led_level
    io.soft_pwm_write led2, led_level
    sleep fade_value
  end
end

## Fade funcion
def fade (io)

# Vars
state = 1
led_count = LED_PINS.length
# Status message
puts "Running with #{led_count} LEDs\n"

# Wait for button to be pressed and fade LEDs
  loop do
    state = io.digital_read BUTTON_PIN
    if state == 0 # Run the routine
      # Fade first LED on
      on_led = 0
      fade_on io, on_led      
      # Iterate through all LEDs  
      led_count.times do |cycle|
        fade_pair io, on_led, on_led + 1
        on_led += 1
      end # end cycle
      # Fade last one out
      fade_off io, on_led      
    end # end if
  end # end loop
end # end method

## Nightrider function
def nightrider (io, speed = 0.003)
  # Vars
  led_count = LED_PINS.length
  on_led = 0


  loop do
    fade_on io, on_led
    # Iterate through all LEDs  
    led_count.times do |cycle|
      fade_pair io, on_led, on_led + 1, speed
      on_led += 1
    end
  fade_off io, on_led
  end
end

## Main program

nightrider io, 0.003
fade io
