#!/bin/bash

while true; do
	level=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage:/ {print int($2)}')
	state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/state:/ {print $2}')

	if [[ $state == "discharging" && $level -le 15 ]]; then
		swayosd-client --custom-icon="battery-caution" --custom-message="low bater: $level%"
		paplay $HOME/dotfiles/sound-theme/stereo/battery-low.oga
		echo "low battery"
	fi

	sleep 5
done
