#!/bin/bash

chosen=$(printf "Power Off\nReboot\nSuspend\n" | wofi --dmenu --prompt "Power Menu")

case "$chosen" in
    "Power Off") systemctl poweroff ;;
    "Reboot") systemctl reboot ;;
    "Suspend") systemctl suspend ;;
esac

