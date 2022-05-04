#!/bin/bash

GAPS=3

# How to get the current inner border from swaymsg
#$ echo $(swaymsg -t get_config | jq ".config") | sed -n '/gaps\ inner/p' | sed 's/gaps\ inner//g' | xargs

bar_mode="$(swaymsg -t get_bar_config bar-0 | jq '.mode')"

if [ "$bar_mode" != "dock" ]; then
  swaymsg bar mode hide bar-0
  swaymsg gaps outer all set 0;
  swaymsg gaps inner all set 0;
else
  swaymsg bar mode dock bar-0
  swaymsg gaps outer all set $GAPS;
  swaymsg gaps inner all set $GAPS;
fi
