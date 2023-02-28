# Introduction 
There are different ways and tools to access BeagleBone's GPIO hardware from programs, but `sysfs` is a simple one that is supported by the **Linux kernel** and makes the devices visible in the file system so we can work from the command line without needing to write any code. For simple applications you can use it with the `sysfs` way, either interactively or by putting the commands in shell scripts.

`Sysfs` is a pseudo filesystem provided by the **Linux kernel** that makes information about various kernel subsystems, hardware devices, and device drivers available in user space through virtual files. GPIO devices appear as part of sysfs.

# RaspberryPi 4 (RBPi4)

**Note: This code and commands have been tested directly on a RaspberryPi4. The GPIO process for the RBPi4 is quiete different fro, the BeagleBone Boards, please considers the instructions for RBPi4 or BBB.**

## Basic considerations

![](./rbpi4.png)

## First steps

The system has some `sysfs` GPIO drivers already loaded, you can search for them at `/sys/class/gpio/`:
```
ls /sys/class/gpio
export  gpiochip0  gpiochip504  unexport
```
We'll look at how to use this interface next. Note that the device names starting with "gpiochip" are the GPIO controllers and we won't directly use them.

Next, the basic steps to use a GPIO pin from the `sysfs` interface are:

1. Export the pin.
2. Set the pin direction (input or output).
3. If an output pin, set the level to low or high.
4. If an input pin, read the pin's level (low or high).
5. When the gpio is not used anymore, unexport the pin.

Thus, to make available the GPIO24 as an output and write a logic 1, we should do:

Export the GPIO24 by
```
echo 24 >> /sys/class/gpio/export
```
then, the `gpio24` linksys file is abilable at
```
ls /sys/class/gpio/
export  gpio24  gpiochip0  gpiochip504  unexport
```
you can go now and observe inside the `gpio24` folder a series of configuration files
```
ls /sys/class/gpio/gpio24/
active_low  device  direction  edge  power  subsystem  uevent  value
```
the ones that we require for now are the `direction` and `value`, then, to make the GPIO24 an output write a logic 1 (3V):
```
echo out >> /sys/class/gpio/gpio24/direction
echo 1 >> /sys/class/gpio/gpio24/value
```

# BeagleBone Black

## Basic considerations

![](./bbb.png)


# Development

There are different types of ports in the BeagleBone Black: GPIO, PWM, Timers, UART, TX, I2C and SPI.
In this case, the topic are the GPIO ports, those can be set as `Input` or `Output`, but there are only a specific number of ports that can be configures with this device, those port numbers are:
`2` to `5`, `7` to `15`, `20`, `22`, `23`, `26`, `27`, `30` to `40`, `44` to `49`, `51`, `60` to `63`, `65` to `81`, `86` to `89`, `100` to `112`, `117`, `123`, `125`.

It is necessary to use at least 3 arguments minimum in case of choosing `Input`, and 4 arguments in the case of `Output`.

## Input configuration 

If you want to configure a specific pin as an `Input`, yo have to follow the next commands:

`./gpio-bash.sh` `gpio` `numberOfPin` `in`

Then, the script will verify if the GPIO's directory exists. If it does, it shall show a message:
```
Final directory - direction: Exists
Final directory - value: Exists
```
That means the process is working correctly. Otherwise, an error message will be deployed.

Following, the pin shall be configured as an `Input`, and finally show the lecture of the pin.
If the lecture shows the number `1`, that means there is a logical signal (3V recommended), or it's floated.
If the lecture shows the number `0`, that means there is no voltage.

Also there is no problem if you write a fourth argument like `0` or `1`, it shall show the same result.
So, a final command could be:
```
./gpio-bash.sh gpio 20 in
```
or 
```
./gpio-bash.sh gpio 20 in 1
```

## Output configuration

If you want to configure a specific pin as an `Output`, you have to  follow the next commands:
`./gpio-bash.sh` `gpio` `numberOfPin` `out` `value`
Then, the script will verify if the GPIO's directory exists. If it does, it shall show a message:
```
Final directory - direction: Exists
Final directory - value: Exists
```
That means the process is working correctly. Otherwise, an error message will be deployed.

The next step is that the pin configured as an `Output` can give 2 different signals:
If the fourth argument was `1`, then the pin will give a logical signal of 3V.
If the fourth argument was `0`, then the pin will have no voltage (0V).

So, a final command could be:
```
./gpio-bash.sh gpio 20 out 1
```
or
```
./gpio-bash.sh gpio 20 out 0
```
Also, if you want to know how the script works at the terminal, you can use the command `help`.
```
`./gpio-bash.sh help`
```
