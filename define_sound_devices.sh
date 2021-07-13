#!/bin/bash

if [[ "$#" -lt 2 || "$#" -gt 3 ]]; then
    echo "Usage: $0 <input_device> <output_device> <output_port>" >&2
    echo "  input_device: Source from pulse audio" >&2
    echo "  output_device: Sink from pulse audio" >&2
    echo "  output_port (optional): Sink port from pulse audio" >&2
    exit 1
fi

source="$1"
sink="$2"
port="$3"

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${scriptDir}/pulse_audio_source.sh ${source}
source ${scriptDir}/pulse_audio_sink.sh ${sink} ${port}
