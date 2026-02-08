#!/bin/bash
# Script for swaync styles

IFS=$'\n\t'

# Define directories
swaync_styles="$HOME/.config/swaync/themes"
swaync_style="$HOME/.config/swaync/style.css"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
rofi_config="$HOME/.config/rofi/config-waybar-style.rasi"
msg=' 🎌 NOTE: Some swaync STYLES NOT fully compatible with some LAYOUTS'

# Function to display menu options
menu() {
    options=()
    while IFS= read -r file; do
        if [ -f "$swaync_styles/$file" ]; then
            options+=("$(basename "$file" .css)")
        fi
    done < <(find -L "$swaync_styles" -maxdepth 1 -type f -name '*.css' -exec basename {} \; | sort )
    
    printf '%s\n' "${options[@]}"
}

# Apply selected style
apply_style() {
    ln -sf "$swaync_styles/$1.css" "$swaync_style"
    "${SCRIPTSDIR}/Refresh.sh" &
}

# Main function
main() {
    choice=$(menu | rofi -i -dmenu -config "$rofi_config" -mesg "$msg")

    if [[ -z "$choice" ]]; then
        echo "No option selected. Exiting."
        exit 0
    fi

    apply_style "$choice"
}

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    #exit 0
fi

main
