#!/bin/bash

if [[ "$#" -lt 1 || "$#" -gt 2 ]]; then
    echo "Usage: $0 <source_id/source_name> <source_port>" >&2
    echo "  source_id/source_name: Source id or name" >&2
    echo "  source_port (optional): Source port" >&2
    echo "Valid sources:" >&2
    pactl list short sources >&2
    exit 1
fi

newSource="$1"
newPort="$2"

pactl set-default-source ${newSource}

if pgrep -x "pipewire-pulse" >/dev/null
then
    # Pipewire
    echo "Nothing to do"
else
    # PulseAudio
    pactl list short source-outputs|while read stream; do
        streamId=$(echo $stream|cut '-d ' -f1)
        echo "moving input stream $streamId"
        pactl move-source-output "$streamId" "$newSource"
    done
fi


if [[ ! -z "$newPort" ]]; then
    echo "changing port to $newPort"
    pactl set-source-port "$newSource" "$newPort"
fi
