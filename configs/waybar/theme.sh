#!/bin/bash

DARK_MODE_STATUS_FILE=~/.cache/dark-mode
CURRENT_DARK_MODE=$( cat $DARK_MODE_STATUS_FILE )

LIGHT="☀️"
DARK="🌙"

echo "\$1 $1"
echo "MODE: $CURRENT_DARK_MODE"

if [ "$1" == "--toggle" ]; then
  if [ $CURRENT_DARK_MODE == "light" ]; then
    ~/.config/waybar/dark-mode.sh dark
  else
    ~/.config/waybar/dark-mode.sh light
  fi
fi

if [ $CURRENT_DARK_MODE != "light" ]; then
  echo $DARK
else
  echo $LIGHT
fi
