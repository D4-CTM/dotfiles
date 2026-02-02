#!/bin/bash

while true; do
	level=$(upower -b | awk '/percentage:/ {print int($2)}')
	state=$(upower -b | awk '/state:/ {print $2}')

	if [[ $state == "discharging" && $level -le 15 ]]; then
		swayosd-client --custom-icon="battery-caution" --custom-message="low bater: $level%"
		paplay $HOME/dotfiles/sound-theme/stereo/battery-low.oga
	fi

	sleep 60
done
