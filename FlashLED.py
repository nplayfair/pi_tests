import time
import RPi.GPIO as GPIO

GPIO.cleanup()
GPIO.setmode(GPIO.BOARD)
GPIO.setup(0,GPIO.OUT)

while True:
	GPIO.output(7,True)
