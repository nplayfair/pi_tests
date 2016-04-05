import time
import RPi.GPIO as GPIO

GPIO.setwarnings(False)
GPIO.cleanup()
GPIO.setmode(GPIO.BOARD)
GPIO.setup(11,GPIO.OUT)
GPIO.setup(12,GPIO.OUT)
GPIO.setup(13,GPIO.OUT)

while True:
	# First LED on
	GPIO.output(11,True)
	GPIO.output(12,False)
	GPIO.output(13,False)
	time.sleep(0.33)

	# Second LED on
	GPIO.output(11,False)
	GPIO.output(12,True)
	GPIO.output(13,False)
	time.sleep(0.33)

	# Third LED on
	GPIO.output(11,False)
        GPIO.output(12,False)
        GPIO.output(13,True)
        time.sleep(0.33)
