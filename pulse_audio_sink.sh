#!/bin/bash

if [[ "$#" -lt 1 || "$#" -gt 2 ]]; then
    echo "Usage: $0 <sink_id/sink_name> <sink_port>" >&2
    echo "  sink_id/sink_name: Sink id or name" >&2
    echo "  sink_port (optional): Sink port" >&2
    echo "Valid sinks:" >&2
    pactl list short sinks >&2
    exit 1
fi

newSink="$1"
newPort="$2"

pactl set-default-sink ${newSink}

if pgrep -x "pipewire-pulse" >/dev/null
then
    # Pipewire
    echo "Nothing to do"
else
    # PulseAudio
    pactl list short sink-inputs|while read stream; do
        streamId=$(echo $stream|cut '-d ' -f1)
        echo "moving stream $streamId"
        pactl move-sink-input "$streamId" "$newSink"
    done
fi

if [[ ! -z "$newPort" ]]; then
    echo "changing port to $newPort"
    pactl set-sink-port "$newSink" "$newPort"
fi
