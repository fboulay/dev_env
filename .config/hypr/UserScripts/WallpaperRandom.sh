#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Random Wallpaper ( CTRL ALT W)

wallDIR="$HOME/Pictures/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
  -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o \) -print0)
RANDOMPICS="${PICS[$((RANDOM % ${#PICS[@]}))]}"


# Transition config
FPS=30
TYPE="random"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

if ! pgrep -x "swww-daemon" >/dev/null; then
    echo "Starting swww-daemon..."
    swww-daemon --format xrgb &
fi
swww img -o "$focused_monitor" "${RANDOMPICS}" $SWWW_PARAMS

wait $!
"$SCRIPTSDIR/WallustSwww.sh" &&

wait $!
sleep 2

if [ "$1" = "nowaybar" ] ; then
  "$SCRIPTSDIR/RefreshNoWaybar.sh"
else
  "$SCRIPTSDIR/Refresh.sh"
fi
