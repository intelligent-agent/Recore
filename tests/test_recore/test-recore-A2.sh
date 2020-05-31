#!/bin/bash

export LC_ALL=C

flash_stm32() {
	echo "** Flashing STM32 with test firmware **"
	echo 1 > /sys/class/gpio/gpio197/value
	echo 0 > /sys/class/gpio/gpio196/value

	stm32flash -i -196,196 -w Sumato-f031.bin -v -g 0x00 /dev/ttyS1
	echo 0 > /sys/class/gpio/gpio197/value
	stm32flash -i -196,196 /dev/ttyS1
}

enable_input() {
	gpioset 1 193=0
	gpioset 1 194=0
}

disable_input() {
	gpioset 1 193=1
	gpioset 1 194=1
}

enable_endstops_5V() {
	gpioset 1 203=1
}

disable_endstops_5V() {
	gpioset 1 203=0
}

enable_endstop_ES5_12V() {
	gpioset 1 199=1
}

disable_endstop_ES5_12V() {
	gpioset 1 199=0
}

enable_thermocouple_5V() {
	gpioset 1 202=1
}

disable_thermocouple_5V() {
	gpioset 1 199=0
}

check_endstop_values(){
	gpioget 0 2 # ES 0
	gpioget 0 3
	gpioget 0 4
	gpioget 0 5
	gpioget 0 6
	gpioget 0 7 # ES 5
}
	
	
get_ADC_values() {
	stty -F /dev/ttyS1 38400
	tail -f /dev/ttyS1 | head -c 200 | sed '0,/^ADC I.*$/d' | sed -n '0,/^ADC I.*$/p'
}



setup_motors() {
	stty -F /dev/ttyS2 raw -echo -echoe
	stty -F /dev/ttyS3 raw -echo -echoe
	
	echo -n -e "\x5\x0\x80\x0\x0\x1\x82\x3f" > /dev/ttyS2
	echo -n -e "\x5\x0\x80\x0\x0\x1\x82\x3f" > /dev/ttyS3
	echo -n -e "\x5\x1\x80\x0\x0\x1\x82\xd3" > /dev/ttyS2
	echo -n -e "\x5\x1\x80\x0\x0\x1\x82\xd3" > /dev/ttyS3
	echo -n -e "\x5\x2\x80\x0\x0\x1\x82\x49" > /dev/ttyS2
	echo -n -e "\x5\x2\x80\x0\x0\x1\x82\x49" > /dev/ttyS3
	echo -n -e "\x5\x3\x80\x0\x0\x1\x82\xa5" > /dev/ttyS2
	echo -n -e "\x5\x3\x80\x0\x0\x1\x82\xa5" > /dev/ttyS3
	echo -n -e "\x5\x0\x90\x0\x0\x0\x0\x50" > /dev/ttyS2
	echo -n -e "\x5\x0\x90\x0\x0\x0\x0\x50" > /dev/ttyS3
	echo -n -e "\x5\x1\x90\x0\x0\x0\x0\xbc" > /dev/ttyS2
	echo -n -e "\x5\x1\x90\x0\x0\x0\x0\xbc" > /dev/ttyS3
	echo -n -e "\x5\x2\x90\x0\x0\x0\x0\x26" > /dev/ttyS2
	echo -n -e "\x5\x2\x90\x0\x0\x0\x0\x26" > /dev/ttyS3
	echo -n -e "\x5\x3\x90\x0\x0\x0\x0\xca" > /dev/ttyS2
	echo -n -e "\x5\x3\x90\x0\x0\x0\x0\xca" > /dev/ttyS3
	echo -n -e "\x5\x0\xec\x15\x0\x0\x53\x63" > /dev/ttyS2
	echo -n -e "\x5\x0\xec\x15\x0\x0\x53\x63" > /dev/ttyS3
	echo -n -e "\x5\x1\xec\x15\x0\x0\x53\x8f" > /dev/ttyS2
	echo -n -e "\x5\x1\xec\x15\x0\x0\x53\x8f" > /dev/ttyS3
	echo -n -e "\x5\x2\xec\x15\x0\x0\x53\x15" > /dev/ttyS2
	echo -n -e "\x5\x2\xec\x15\x0\x0\x53\x15" > /dev/ttyS3
	echo -n -e "\x5\x3\xec\x15\x0\x0\x53\xf9" > /dev/ttyS2
	echo -n -e "\x5\x3\xec\x15\x0\x0\x53\xf9" > /dev/ttyS3

}



step_motor() {
	step_pin=$1
	dir_pin=$2
	es=$3
	
	gpioset 1 $dir_pin=0

	for i in {1..1000}
	do
  	gpioset 1 $step_pin=1
  	gpioset 1 $step_pin=0
  	es0=`gpioget 0 $es`
  	if [ $es0 = "1" ]
  	then
	  	echo "End stop hit"
	  	break
	  fi
	done
	
	gpioset 1 $dir_pin=1
	
	for i in {1..100}
	do
  	gpioset 1 $step_pin=1
  	gpioset 1 $step_pin=0
	done
}


enable_input
setup_motors

enable_endstops_5V
step_motor 128 136 2
step_motor 129 137 3
step_motor 130 138 4
step_motor 131 139 5
step_motor 132 140 6
step_motor 133 141 7

sleep 0.01
enable_endstop_ES5_12V
sleep 0.01
disable_endstop_ES5_12V
enable_thermocouple_5V

sleep 0.01

disable_endstops_5V
disable_thermocouple_5V
get_ADC_values
disable_input


