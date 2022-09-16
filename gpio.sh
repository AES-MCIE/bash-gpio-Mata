#!/bin/bash

echo "Script is executing"

gpio24=/sys/class/gpio/gpio24

function gpioUnexport
{
	echo 24 >> /sys/class/gpio/unexport
	echo "gpioUnexport succesfull"
}

function gpioExport
{
	echo 24 >> /sys/class/gpio/export
	echo "gpioExport succesfull"
}

function gpioDirection
{
	echo out >> $gpio24/direction
	echo "gpioDirection succesfull"
}

function gpioValue
{
	echo 1 >> $gpio24/value
	echo "gpioValue succesfull"
}

gpioUnexport
gpioExport
gpioDirection
gpioValue
