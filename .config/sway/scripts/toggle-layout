#!/bin/bash

WORKSPACE=$(swaymsg -t get_workspaces --raw | jq '.[] | select(.focused == true)')


WORKSPACE_ID=$(echo $WORKSPACE | jq ".name" | tr -d '"')
WORKSPACE_MODE=$(swaymsg -t get_tree | jq 'recurse(.nodes[]) | select(.nodes[].focused == true).layout');
echo "WORKSPACE: $WORKSPACE_MODE"

MODE_SPLITH='"splith"'
MODE_SPLITV='"splitv"'
MODE_TABBED='"tabbed"'
MODE_STACKED='"stacked"'

function set_layout(){
  swaymsg "workspace $(swaymsg -t get_workspaces --raw | jq '.[] | select(.focused == true) .name'); layout $1"
}

if [ $WORKSPACE_MODE = $MODE_SPLITH ]; then
	set_layout splitv
elif [ $WORKSPACE_MODE = $MODE_SPLITV ]; then
	set_layout tabbed
# elif [ $WORKSPACE_MODE = $MODE_TABBED ]; then
# 	set_layout stacking
elif [ $WORKSPACE_MODE = $MODE_TABBED ]; then
	set_layout splith
fi

if [ "$1" != "" ]; then
  set_layout $1
fi
