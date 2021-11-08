#!/bin/bash

WORKSPACE=$(swaymsg -t get_workspaces --raw | jq '.[] | select(.focused == true)')

WORKSPACE_ID=$(echo $WORKSPACE | jq ".name")
WORKSPACE_MODE=$(echo $WORKSPACE | jq ".layout");

MODE_SPLITH='"splith"'
MODE_SPLITV='"splitv"'
MODE_TABBED='"tabbed"'
MODE_STACKED='"stacked"'

echo $WORKSPACE_MODE

if [ $WORKSPACE_MODE = $MODE_SPLITH ]; then
	swaymsg "workspace $WORKSPACE_ID; layout splitv"
elif [ $WORKSPACE_MODE = $MODE_SPLITV ]; then
	swaymsg "workspace $WORKSPACE_ID; layout tabbed"
elif [ $WORKSPACE_MODE = $MODE_TABBED ]; then
	swaymsg "workspace $WORKSPACE_ID; layout stacking"
elif [ $WORKSPACE_MODE = $MODE_STACKED ]; then
	swaymsg "workspace $WORKSPACE_ID; layout splith"
fi

echo $WORKSPACE_ID;

