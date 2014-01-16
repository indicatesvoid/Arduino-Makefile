#!/bin/bash

cp -r ./arduino-mk /usr/local
ln -s /usr/local/arduino-mk/arduino-mk.sh /usr/local/bin/arduino-mk

echo "* arduino-mk installed! *"
echo "* to create a new makefile for your project run 'arduino-mk' and pass in the path to your project directory *"
echo "* then type 'make upload' to compile your and upload your sketch *"
echo "* if you forget just type 'arduino-mk' for help *"