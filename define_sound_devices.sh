#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -i|--input-device)
      inputDevice="$2"
      shift # past argument
      shift # past value
      ;;
    -o|--output-device)
      outputDevice="$2"
      shift # past argument
      shift # past value
      ;;
    -ip|--input-port)
      inputPort="$2"
      shift # past argument
      shift # past value
      ;;
    -op|--output-port)
      outputPort="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$key") # save it in an array for later
      shift # past argument
      ;;
  esac
done

if [[ -z "${inputDevice}" || -z "${outputDevice}" || "${#POSITIONAL[@]}" -gt 0 ]]; then
    if [[ "${#POSITIONAL[@]}" -gt 0 ]]; then
        echo "Unknown options ${POSITIONAL[@]}" >&2
    fi

    echo "Usage: $0 [option...]" >&2
    echo >&2
    echo "   -i,  --input-device          Source from pulse audio" >&2
    echo "   -o,  --output-device         Sink from pulse audio" >&2
    echo "   -ip, --input-port            Source port from pulse audio" >&2
    echo "   -op, --output-port           Sink port from pulse audio" >&2
    exit 1
fi

# compute script directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${scriptDir}/pulse_audio_source.sh ${inputDevice} ${inputPort}
source ${scriptDir}/pulse_audio_sink.sh ${outputDevice} ${outputPort}
