#!/bin/bash

chosen=$(printf "  Power Off\n  Reboot\n  Suspend\n  Lock\n  Logout" | wofi --dmenu --prompt "Power Menu")

case "$chosen" in
    "  Power Off") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "  Suspend") systemctl suspend ;;
    "  Lock") hyprlock ;;
    "  Logout") hyprctl dispatch exit ;;
esac

