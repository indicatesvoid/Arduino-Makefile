#!/bin/bash

flag=$1

# check if flag is a directory #
if [ ! -z $1 ] && [ -d $flag ]; then
	cd $flag
	echo Installing Makefile at `pwd`
	echo BOARD_TAG = uno > Makefile
	echo MONITOR_PORT = /dev/cu.usb* >> Makefile
	echo ARDUINO_LIBS = >> Makefile
	echo include /usr/local/arduino-mk/Arduino.mk >> Makefile
else
	echo "------------------------------------------------------------------------------------------------------------"
	echo ">> arduino-mk"
	echo ">> to create a new makefile for your project run 'arduino-mk' and pass in the path to your project directory"
	echo ">> then type 'make upload' to compile and upload your sketch *"
	echo "------------------------------------------------------------------------------------------------------------"
fi