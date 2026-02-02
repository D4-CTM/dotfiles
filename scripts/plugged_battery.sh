#!/bin/bash

old_state=$(upower -b | awk '/state:/ {print $2}')
while true; do
	state=$(upower -b | awk '/state:/ {print $2}')

	if [[ $old_state != $state ]]; then
		case "$state" in
			discharging)
				paplay ~/dotfiles/sound-theme/stereo/power-unplug.oga
			;;
			charging)
                paplay ~/dotfiles/sound-theme/stereo/power-plug.oga
			;;
		esac
		old_state="$state"
	fi
done
