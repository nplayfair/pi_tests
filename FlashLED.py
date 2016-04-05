import time
import RPi.GPIO as GPIO

lights = [11, 12, 13, 15]
delay = 0.08

GPIO.setwarnings(False)
GPIO.cleanup(lights)
GPIO.setmode(GPIO.BOARD)
GPIO.setup(11,GPIO.OUT)
GPIO.setup(12,GPIO.OUT)
GPIO.setup(13,GPIO.OUT)
GPIO.setup(15,GPIO.OUT)

# Quick Test
GPIO.output(lights,1)
time.sleep(1)
GPIO.output(lights,0)

while True:
	# First LED on
	GPIO.output(11,1)
	GPIO.output(12,0)
	GPIO.output(13,0)
	GPIO.output(15,0)
	time.sleep(delay)

	# Second LED on
	GPIO.output(11,0)
	GPIO.output(12,1)
	GPIO.output(13,0)
	GPIO.output(15,0)
	time.sleep(delay)

	# Third LED on
	GPIO.output(11,0)
        GPIO.output(12,0)
        GPIO.output(13,1)
        GPIO.output(15,0)
	time.sleep(delay)

	# Fourth LED on
        GPIO.output(11,0)
        GPIO.output(12,0)
        GPIO.output(13,0)
        GPIO.output(15,1)
        time.sleep(delay)

	# Third LED on   
        GPIO.output(11,0)
        GPIO.output(12,0)
        GPIO.output(13,1)
        GPIO.output(15,0)
        time.sleep(delay)

	# Second LED on
        GPIO.output(11,0)
        GPIO.output(12,1)
        GPIO.output(13,0)
	GPIO.output(15,0)
        time.sleep(delay)	
