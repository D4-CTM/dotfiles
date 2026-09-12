#!/bin/bash

pkill wf-recorder
wf-recorder -a "$(pactl get-default-sink).monitor" -f ~/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4
