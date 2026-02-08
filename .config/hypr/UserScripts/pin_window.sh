#!/bin/bash
#
# Toggle pin for current window

image_notif="$HOME/.config/swaync/images/ja.png"
pin_active=$(hyprctl activewindow  | grep pinned | cut -d " " -f 2)
window_class=$(hyprctl activewindow  | grep class | cut -d " " -f 2)

if [ "$pin_active" -eq "0" ] ; then
    title_notif="Pin enabled"
else
    title_notif="Pin disabled"
fi

notify-send -e -i "$image_notif" -u low "$title_notif" "for window $window_class"
hyprctl dispatch pin
