#!/bin/bash

GAPS=3

# How to get the current inner border from swaymsg
#$ echo $(swaymsg -t get_config | jq ".config") | sed -n '/gaps\ inner/p' | sed 's/gaps\ inner//g' | xargs

if [ "$(ps cax | grep waybar$)" != "" ]; then
  swaymsg gaps outer all set 0;
  swaymsg gaps inner all set 0;
  killall waybar;
else
  swaymsg gaps outer all set $GAPS;
  swaymsg gaps inner all set $GAPS;
  nohup waybar & 2&> /dev/null;
fi
