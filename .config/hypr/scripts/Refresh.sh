#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing ags, waybar, rofi, swaync, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts
UserScripts=$HOME/.config/hypr/UserScripts

arg_verb="$1"
# `nowaybar` means, do not refresh waybar
[[ -n "$arg_verb" && "$arg_verb" == "nowaybar" ]] 
nowaybar=$?

# Define file_exists function
file_exists() {
    if [ -e "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# Kill already running processes
_ps=(waybar rofi swaync)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        if [[ "$_prs" = "waybar" && $nowaybar == 1 ]]; then
            pkill "${_prs}"
        fi
    fi
done

# added since wallust sometimes not applying
if [[  $nowaybar == 1 ]]; then
    killall -SIGUSR2 waybar 
fi


# some process to kill
# for pid in $(pidof waybar rofi swaync swaybg); do
#     kill -SIGUSR1 "$pid"
# done

#Restart waybar
if [[ $nowaybar == 1 ]]; then
    sleep 1
    waybar &
fi

# relaunch swaync
sleep 0.5
swaync > /dev/null 2>&1 &
# reload swaync
swaync-client --reload-config
swaync-client --reload-css

# Relaunching rainbow borders if the script exists
sleep 1
if file_exists "${UserScripts}/RainbowBorders.sh"; then
    "${UserScripts}"/RainbowBorders.sh &
fi

exit 0
