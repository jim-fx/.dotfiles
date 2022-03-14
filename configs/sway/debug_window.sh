#!/bin/bash

ALL_NODES='recurse(.nodes[]?, .floating_nodes[]?) | select(.pid and .visible)'
WINDOW_NAME='(.app_id // .window_properties.class)'
ID_PREFIX='"\(.pid):"'
WINDOW_PROTOCOL='(if .shell == "xwayland" then "X11" else "wayland" end)'
WINDOW_GEOMETRY='(.rect | "\(.x),\(.y) \(.width)x\(.height) ")'
WINDOW_PID='(.pid | tostring)'
CLEAR_OBJ="del(.rect, .name, .focus, .border, .current_border_width, .window_rect, .orientation, .layout, .percent, .deco_rect, .geometry, .window, .urgent, .marks, .sticky, .type, .fullscreen_mode, .nodes, .floating_nodes, .shell, .max_render_time, .visible, .idle_inhibitors, .inhibit_idle)"

# Output format, e.g. "1234 - 12:firefox (wayland)" or "5678 - 17:discord (X11)"
FORMAT="$WINDOW_PID"
FILT="$ALL_NODES | $WINDOW_GEOMETRY + $FORMAT"

function getprop() {
	typeset -A views
	local selected

	while read POS GEOM INFO; do
		views["$POS $GEOM"]="$INFO"
	done


	selected="$(printf "%s\n" "${!views[@]}" | slurp)"
	if [[ -n "$selected" ]]; then
   window_id=${views[${selected}]};
   SELECT_ID=$(echo ".. | (.nodes? // empty)[] | select(.pid == $window_id) | $CLEAR_OBJ ")
   echo $SELECT_ID
   notify "Debug:" "$(swaymsg -t get_tree | jq -r "$SELECT_ID")";
	fi
}

swaymsg -t get_tree | jq -r "$FILT" | getprop
