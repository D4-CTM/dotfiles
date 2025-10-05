#!/bin/bash

notify_mute() {
	read mute <<< $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

	info="is unmuted"
	if [ "$mute" = "[MUTED]" ]; then
		info="is muted"
	fi
	notify-send -t 750 "Output device $info"
}

notify_volume() {
	read vol mute <<< $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2, $3}')
    percent=$(awk -v v="$vol" 'BEGIN { printf "%d", v * 100 }')
	
	notify-send -a progress -t 1000 -h 'string:wired-tag:volume' -h "int:value:$percent" 'Volume' "$percent%"
}

notify_brightness() {
	notify-send -a progress -t 1000 -h 'string:wired-tag:brightness' -h "int:value:$target" 'Brightness' 
}

notify_track() {
	# wait for mpris to update
	sleep 0.4
	art_url="$(playerctl metadata -f '{{mpris:artUrl}}' | sed 's/file:\/\///')"
	if [ -z "$art_url" ]; then
		notify-send -h 'string:wired-tag:player' -t 10000 'Player' "$(playerctl metadata -f '{{artist}} —  {{title}}')"
	else
		notify-send -h 'string:wired-tag:player' -t 10000 -h "string:image-path:$art_url" 'Player' "$(playerctl metadata -f '{{artist}} —  {{title}}')"
	fi
}

case "$1" in
	up)
		wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
		notify_volume
	;;

	down)
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
		notify_volume
	;;

	mutetoggle)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
		notify_mute
	;;

	light_up)
		brightnessctl -e4 -n2 set 5%+
		cur=$(brightnessctl g)
		max=$(brightnessctl m)
		percent=$(( cur * 100 / max ))
		target=$percent
		notify_brightness
	;;

	light_down)
		brightnessctl -e4 -n2 set 5%-
		cur=$(brightnessctl g)
		max=$(brightnessctl m)
		percent=$(( cur * 100 / max ))
		target=$percent
		notify_brightness
	;;

	play_pause)
		playerctl play-pause
		notify_track
		;;

	next)
		playerctl next
		notify_track
		;;
	
	previous)
		playerctl previous
		notify_track
		;;
esac
