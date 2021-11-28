#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:


searx="https://searx.tiekoetter.com/search?language=en&time_range=None&safesearch=0&categories=general&q="
startpage="https://www.startpage.com/sp/search?q="

query=$( wofi -d -p "Search: " -W 600 -H 100 -k ~/.cache/wofi-web)

if [[ -n "$query" ]]; then
  url="$startpage$query"
  xdg-open "$url"
else
  exit
fi

exit 0
