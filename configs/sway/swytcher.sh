#!/bin/bash

#    Swytch is a script providing a window switcher for sway using rofi, awk and jq.
#    The script is based on:
#    https://www.reddit.com/r/swaywm/comments/aolf3u/quick_script_for_rofi_alttabbing_window_switcher/
#    Copyright (C) 2019  Björn Sonnenschein
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


# todo: first, query all existing workspaces from sway and build color dict, so that
#   all workspaces always get the same color, even if no windows at some workspace in between exists.

# obtain command to execute with swaymsg for selected window
if [ -z "$1" ]
then 
		command_=focus
else
    command_=$1
fi


# Obtain the avaliable windows' workspaces, names and IDs as strings
mapfile -t windows < <(
swaymsg -t get_tree | jq -r '[
    recurse(.nodes[]?)
    |recurse(.floating_nodes[]?)
    |select(.type=="workspace")
    | . as $workspace | recurse(.nodes[]?)
    |select(.type=="con" and .name!=null)
    |{workspace: $workspace.name, name: .name, id: .id, focused: .focused, app_id: .app_id, class: .window_properties.class}]
    |sort_by(.workspace, .name)[]
    |.workspace + if .focused then "* " else "  " end + if .app_id then .app_id else .class end + " - " +  .name + "  " + (.id|tostring)'
)

# Obtain window list index of last active window
# todo
index_window_last_active=0
for index_window in "${!windows[@]}"
do 
    window="${windows[$index_window]}"
    # obtain index of the active window
    if [ "${window:1:1}" == "*" ]
    then 
        index_window_last_active=$(($index_window))
        break
    fi
done

# get window list to display
windows_separators=()
colors=(blue green orange red magenta)
workspace_previous=''
index_workspace_active=0
num_separators=0
index_color=0
bold=-1
for index_window in "${!windows[@]}"
do 
    window="${windows[$index_window]}"
    # todo: consider arbitraty workspace name length by separating by space instead of simply taking first argument.
    workspace=${window:0:1}
    # obtain index of the active window
    if [ "${window:1:1}" == "*" ]
    then 
        index_workspace_active=$(($index_window))
    fi
    
    # if window has different workspace than previous, use next color. Cycle through colors
    if [ "$workspace" != "$workspace_previous" ] && [ ! -z "$workspace_previous" ]
    then
        index_color=$index_color+1
    fi
    
    if (($index_color == ${#colors[@]}))
    then	
        index_color=0
    fi
    if (( $bold == 1)) 
    then
        windows_separators+=("<b><span foreground=\"${colors[$index_color]}\">[${workspace}]</span>${window:1}</b>")
    else
        windows_separators+=("<span foreground=\"${colors[$index_color]}\">[${workspace}]</span>${window:1}")
    fi
    workspace_previous=$workspace
done

# TODO: this breaks when using i3. Comment out for now. Should only execute if running sway.
# Select window with rofi, obtaining ID of selected window
#screen_pos=$(swaymsg -t get_outputs \
#	| jq -r \
#	'.[] | select(.focused).rect | "\(.width)x\(.height)\\+\(.x)\\+\(.y)"')

# ripgrep
#xwayland_output=$(xrandr | rg -oP "[A-Z]+[0-9]+(?= [a-z]+ $screen_pos)")

#monitor_id=$(rofi --help | rg $xwayland_output -B1 \
#	| sed -sr '/ID/!d;s/[^:]*:\s([0-9])/\1/')


# Select window with rofi, obtaining ID of selected window
# TODO: Use multiple columns while inserting appropriate empty lines
#	and adjusting line number accordingly in order to visually
#	separate the list by workspace

if [ -z "$monitor_id" ]
then 
	idx_selected=$printf '%s\n' "${windows_separators[@]}" | rofi -dmenu -i -p "$command_" -a "$index_workspace_active" -format i -selected-row "$index_window_last_active" -no-custom -s -width 80 -lines 30 -markup-rows)
else	
	idx_selected=$(printf '%s\n' "${windows_separators[@]}" | rofi  -monitor $monitor_id -dmenu -i -p "$command_" -a "$index_workspace_active" -format i -selected-row "$index_window_last_active" -no-custom -s -width 80 -lines 30 -markup-rows)
fi

# if no entry selected (e.g. user exitted with escape), end
if [ -z "$idx_selected" ]
then
    exit 1
fi
selected=${windows[$idx_selected]}
id_selected=$(echo $selected | awk '{print $NF}')
workspace_selected=${selected:0:1}


### unmaximize all maximized windows on the workspace of the selected window
# Obtain the avaliable windows' workspaces, names and IDs as strings
mapfile -t ids_windows_maximized < <(
swaymsg -t get_tree | jq -r '[
    recurse(.nodes[]?)
    |recurse(.floating_nodes[]?)
    |select(.type=="workspace")
    | . as $workspace | recurse(.nodes[]?)
    |select(.type=="con" and .name!=null and .fullscreen_mode==1 and $workspace.name=="'"$workspace_selected"'")
    |{workspace: $workspace.name, name: .name, id: .id, focused: .focused, app_id: .app_id}]
    |sort_by(.workspace, .name)[]
    |(.id|tostring)'
)

# unmaximize the maximized windows that are not the selected one
for id_window_maximized in "${ids_windows_maximized[@]}"
do 
    if [ "$id_window_maximized" != "$id_selected" ]
    then
        swaymsg "[con_id=$id_window_maximized] fullscreen disable"
    fi
done

# Tell sway to focus said window
if [ ! -z "$id_selected" ]
then
    swaymsg "[con_id=$id_selected] $command_"
fi(
