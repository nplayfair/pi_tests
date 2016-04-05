import time
import RPi.GPIO as GPIO

GPIO.setwarnings(False)
GPIO.cleanup()
GPIO.setmode(GPIO.BOARD)
GPIO.setup(11,GPIO.OUT)
GPIO.setup(12,GPIO.OUT)

while True:
	GPIO.output(11,True)
	GPIO.output(12,False)
	time.sleep(0.5)
	GPIO.output(11,False)
	GPIO.output(12,True)
	time.sleep(0.5)
