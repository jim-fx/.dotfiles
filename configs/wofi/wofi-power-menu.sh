#!/bin/bash

entries="⏻ Shutdown\n⭮ Reboot\n⇠ Logout\n⏾ Suspend"

selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec shutdown now;;
esac
