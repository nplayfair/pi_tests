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

## Switch Pair
def switch_pair (io, led0, led1, delay = 0.1)
  state = []

  state[0] = io.digital_read led0
  state[1] = io.digital_read led1
  sleep delay
  io.digital_write led0, state[1] 
  io.digital_write led1, state[0]
  #puts "led 1: #{state[0]}\nled 2: #{state[1]}"
  sleep delay
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

## Nightrider Fader
def nightrider_fade (io, speed = 0.003)
  # Vars
  led_count = LED_PINS.length
  on_led = 0
  
  loop do
    fade_on io, on_led
    # Iterate up through all LEDs  
    led_count.times do |cycle|
      fade_pair io, on_led, on_led + 1, speed
      on_led += 1
    end
    #on_led += 1
    fade_off io, on_led
    # Iterate down through LEDs
    led_count.times do |cycle|
      fade_pair io, on_led, on_led -1, speed
      on_led -= 1
    end
  end
end

## Nightrider Binary Mode

def nightrider_binary (io, delay = 0.003)
  
  # Set Pin Mode
  LED_PINS.each do |led|
  io.pin_mode led, WiringPi::OUTPUT
end

  # Vars
  led_count = LED_PINS.length
  on_led = 0
  
  loop do
    io.digital_write on_led, 1
    # Iterate up through all LEDs  
    led_count.times do |cycle|
      switch_pair io, on_led, on_led + 1, delay
      on_led += 1
    end
    #on_led += 1
    io.digital_write on_led, 1
    # Iterate down through LEDs
    led_count.times do |cycle|
      switch_pair io, on_led, on_led -1, delay
      on_led -= 1
    end
  end
end


## Main program

#nightrider_fade io, 0.003

#io.digital_write 0, 1
#switch_pair io, 0, 1, 0.5

nightrider_binary io, 0.5
