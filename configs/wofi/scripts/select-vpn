#!/usr/bin/env bash
# Connect to VPN connections

# Starts a scan of available broadcasting SSIDs
# nmcli dev wifi rescan
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FIELDS=NAME,TYPE,STATE
POSITION=0
XOFF=-30
LOC=3
CACHE=~/.local/tmp/vpn-wofi
WWIDTH=340

LIST=$(nmcli --fields "$FIELDS" connection show | awk \
    -F "[  ]{2,}" \
    '$2 ~ /vpn/ {
      sub(/activated/, "");
      sub(/activating/, "");
      sub(/--/, "");
      printf "<tt>%-30s\t</tt>%s\n", $1,$3 }')

# Dynamically change the height of the rofi menu
LINENUM=$(echo "$LIST" | wc -l)

WHEIGHT=$((30*$LINENUM))

CHENTRY=$(echo -e "$LIST" | uniq -u | \
    wofi -i \
    --dmenu \
    -p "Choose a VPN connection: " \
    --width "$WWIDTH" \
    --height $WHEIGHT \
    --cache-file ${CACHE} \
    --location $LOC \
    --xoffset $XOFF | \
    sed -e 's/<[^>]*>//g')

rm ${CACHE}

ACTIVE=$(echo $CHENTRY | awk -F "[  ]{2,}" '{print //}')

VPNID=$(echo "$CHENTRY" | awk -F "[  ]{2,}" '{print $1}')

# It is assumed that if the connection is in active, then
# the user wants to deactivate it
if [[ $ACTIVE =~ 1 ]]; then
    nmcli connection down "$VPNID"
else
    nmcli connection up "$VPNID"
fi

pkill -SIGRTMIN+2 waybar
