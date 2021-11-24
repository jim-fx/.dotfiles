#!/bin/bash

GAPS_OUTER=5
GAPS_INNER=1

if [ "$(pgrep waybar)" != "" ]; then
  killall waybar;
  swaymsg gaps outer all set 0;
  swaymsg gaps inner all set 0;
else
  swaymsg gaps outer all set $GAPS_OUTER;
  swaymsg gaps inner all set $GAPS_INNER;
  nohup waybar & 2&> /dev/null;
fi
