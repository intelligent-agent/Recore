#!/bin/bash

export LC_ALL=C

enable_input() {
	gpioset 1 193=0
	gpioset 1 194=0
}

disable_input() {
	gpioset 1 193=1
	gpioset 1 194=1
}

	
enable_output() {
	gpioset 1 196=1
}	
	
disable_output() {
	gpioset 1 196=0
}	


get_ADC_values() {
	stty -F /dev/ttyS1 38400 raw
	cat /dev/ttyS1 | head -c 200 | awk '/I:/ { printf "scale=4; (%i/4096)*33\n", $3 }' | bc -l
}

enable_input
for i in {1..300}
do
	get_ADC_values
	sleep 0.1
done
disable_input


