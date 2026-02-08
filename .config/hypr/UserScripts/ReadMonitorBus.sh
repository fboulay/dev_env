#!/usr/bin/env bash
# Detect connected monitors, and store their respective ddcutil bus in a file

cache_file="$HOME/.cache/.ddcutil_bus"

display_name="Display 1"
display1_bus=$(ddcutil detect --brief | grep -A1 "$display_name" | grep bus | cut -d "-" -f 2)

if [ -z "$display1_bus" ] ; then
    echo "" > "$cache_file"
else
    echo "$display_name,$display1_bus" > "$cache_file"
fi
