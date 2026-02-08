#!/usr/bin/env bash
# Check if there are apps in full screen. If this is the case, gamemode is enabled

# prev_state="false"
prev_count=0

while true; do
    # current_state=$(hyprctl -j activewindow | jq -r '.fullscreen')                        # Check if active window is full screen
    current_count=$(hyprctl -j clients | jq -r "[.[] | select(.fullscreen == 2)] | length") # Count number of fullscreen windows

    # if [ "$current_state" != "$prev_state" ]; then
    if [ "$current_count" != "$prev_count" ]; then
        # if [ "$current_state" = "true" ]; then
        if [ "$current_count" != "0" ]; then
            "$HOME"/.config/hypr/scripts/GameMode.sh enable
        else
            "$HOME"/.config/hypr/scripts/GameMode.sh disable
        fi
        # prev_state="$current_state"
        prev_count=$current_count
    fi
    sleep 0.5
done
