
#!/bin/sh

# ------Get available windows:
windows=$(swaymsg -t get_tree | jq -r '
	recurse(.nodes[]?) |
		recurse(.floating_nodes[]?) |
		select(.type=="con"), select(.type=="floating_con") |
			(.id | tostring) + " " + .app_id + ": " + .name')

# ------Limit wofi's height with the number of opened windows:
height=$(echo "$windows" | wc -l)
height=$(($height + 2))

# ------Select window with wofi:
selected=$(echo "$windows" | wofi -d --lines $height -i -p "Switch to:" | awk '{print $1}')

# ------Tell sway to focus said window:
swaymsg [con_id="$selected"] focus
