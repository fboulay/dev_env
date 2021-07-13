#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <sinkId/sinkName>" >&2
    echo "Valid sources:" >&2
    pactl list short sources >&2
    exit 1
fi

newSource="$1"

pacmd set-default-source ${newSource}

pactl list short source-outputs|while read stream; do
    streamId=$(echo $stream|cut '-d ' -f1)
    echo "moving input stream $streamId"
    pactl move-source-output "$streamId" "$newSource"
done
