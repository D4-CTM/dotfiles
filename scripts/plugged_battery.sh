#!/bin/bash

state=""
acpi_listen | while read -r line; do
    case "$line" in
        ac_adapter*)  # only match lines starting with ac_adapter
			if [[ "$state" == "$line" ]]; then
				continue
			fi

            if [[ "$line" == *00000001 ]]; then
				state="$line"
                paplay ~/dotfiles/sound-theme/stereo/power-plug.oga
            elif [[ "$line" == *00000000 ]]; then
				state="$line"
                paplay ~/dotfiles/sound-theme/stereo/power-unplug.oga
            fi
            ;;
    esac
done
