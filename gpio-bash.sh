#! /bin/bash

direct=/sys/class/gpio/gpio

exe=$1
port=$2
assig=$3
value=$4

function unexportPin
{
	echo $port >> /sys/class/gpio/unexport
	echo "	Unexport state: succesfull"
}

function exportPin
{
	echo $port >> /sys/class/gpio/export
	echo "	Export state: succesfull"
}

function OutPort
{
	echo out >> $direct$port/direction
	echo 0 >> $direct$port/value
	echo "	Direction done:		 OUT port"
}

function InPort
{
	echo in >> $direct$port/direction
	echo "	Direction done:		IN port"
}

function getValue
{
	echo "	The lecture value is:"
	cat $direct$port/value
}

function error
{
	echo "	ERROR --- Wrong arguments ---"
	echo ""
	echo "	Try, ./gpio-bash.sh gpio 60 out 1"
	echo ""
	echo "	For help, type"
	echo "	./gpio-bash.sh help"
	exit 0
}

function helpMenu
{
	echo ""
	echo "		How to use Gpio Script"
	echo "		There are diferents types of ports in the BeagleBone Black, this is a script for the GPIO's ports, that means the In or Out logical ports."
	echo "		So there are only a specific number of ports that can be configured with this script, those numbers are:"
	echo "		2 to 5, 7 to 15, 20, 22, 23, 26, 27, 30 to 40, 44 to 49, 51, 60 to 63, 65 to 81, 86 to 89, 100 to 112, 117, 123, 125."
	echo ""
	echo "---	The first argument must have the word 'gpio' to specify the configuration of the pin"
	echo ""
	echo "---	The second argument must have one of the numbers that have been specified before"
	echo ""
	echo "		The GPIO's can be set on INPUT or OUTPUT"
	echo "---	The third argument must have the next options:"
	echo "	-in		The GPIO shall be configured as an INPUT"
	echo "	-out		The GPIO shall be condigured as an OUTPUT"
	echo ""
	echo "---	The fourth argument needs to use one of two numbers."
	echo "		In case of chooshing OUTPUT, it is necesary to specify the value of the output"
	echo "	-1		The value of the output change to 1 (3V)"
	echo "	-0		The value of the output change to 0 (0V)"
	echo "		In case of choosing INPUT, there is no differences between choosing 0 or 1"
	echo "		Also, there is no problem if the fourth argument is not given"
	echo ""
	echo "		For example: "
	echo "		./gpio-bash.sh gpio 60 out 1"
	exit 0
}

function verifyDirection
{
	if [ -d "$direct$port/" ]; then
		echo "	Final directory - direction: Exists"
		echo "	Final directory - value: Exists"
	else
		echo "	Final directories: non-existent"
		error
	fi
}

if [ $1 == help ]; then
	helpMenu
elif [ $1 == gpio ]; then
	verifyDirection
	echo "---		The script is executing		---"
	if [ $assig == in ]; then
		InPort
		if [ -z "$value" ]; then
			getValue
			exit 0
		else
			if [ $value -le 1 ]; then
				getValue
				exit 0
			fi
		fi
	elif [ $assig == out ]; then
		OutPort
		if [ -z "$value" ]; then
			echo "	WARNING --- There is not a value for the OUTPUT ---"
			error
		else
			if [ $value -eq 0 ]; then
				echo 0 >> $direct$port/value
				echo "		Output value: 0"
			elif [ $value -eq 1 ]; then
				echo 1 >> $direct$port/value
				echo "		Output value: 1"
			fi
			exit 0
		fi
	fi
else
	error
fi

