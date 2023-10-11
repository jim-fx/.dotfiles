#!/usr/bin/env bash

$@ &
pid=$!


ALL_NODES='recurse(.nodes[]?, .floating_nodes[]?) | select(.pid and .visible)'

sleep 0.3

all_nodes="$(swaymsg -t get_tree | jq -r "$ALL_NODES" | jq -c '.pid')"
window_id="$(swaymsg -t get_tree | jq -r "$ALL_NODES" | jq --argjson pid $pid -c 'select(.pid==$pid).id')"
swaymsg "[ con_id=$window_id ] floating enable, resize set 800 400, move position 1115 670, sticky enable"

# swaymsg -t subscribe -m '[ "window" ]' \
#   | jq --unbuffered --argjson pid "$pid" '.container | select(.pid == $pid) | .id' \
#   | xargs -I '@' -- swaymsg '[ con_id=@ ] floating enable' &

# subscription=$!

# echo Going into wait state

# # Wait for our process to close
# tail --pid=$pid -f /dev/null

# echo Killing subscription
# kill $subscription
