#!/usr/bin/env bash

$@ &
pid=$!


# ALL_NODES='recurse(.nodes[]?, .floating_nodes[]?) | select(.pid and .visible)'

# echo "pid: $pid"
# all_nodes="$(swaymsg -t get_tree | jq -r "$ALL_NODES")"
# window_id="$(swaymsg -t get_tree | jq -r "$ALL_NODES" | jq -c ". | select(.pid==$pid) | .id")"

# echo "al: $all_nodes"
# echo "window_id: $window_id"

swaymsg -t subscribe -m '[ "window" ]' \
  | jq --unbuffered --argjson pid "$pid" '.container | select(.pid == $pid) | .id' \
  | xargs -I '@' -- swaymsg '[ con_id=@ ] floating enable' &

subscription=$!

echo Going into wait state

# Wait for our process to close
tail --pid=$pid -f /dev/null

echo Killing subscription
kill $subscription
