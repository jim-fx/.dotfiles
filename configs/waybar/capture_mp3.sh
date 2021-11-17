#!/bin/bash
cd "$(dirname "$0")"

arecord -f cd -t raw -d 4 -q | lame -r -q - output.mp3 2>/dev/null

if [ ! -f "./output.mp3" ]; then
	exit 0
fi

JSON=$(songrec audio-file-to-recognized-song output.mp3)

RETRYMS=$(echo $JSON | jq '.retryms')

if [ $RETRYMS != null ]; then
	echo $(expr $RETRYMS / 1000)
else
	SONG=$(echo $JSON | tr '\r\n' ' ' | jq '.track.share.subject')
	echo $SONG
	rm -rf output.mp3
fi
