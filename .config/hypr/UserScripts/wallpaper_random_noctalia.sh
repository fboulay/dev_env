#!/usr/bin/env bash

# qs -c noctalia-shell ipc call wallpaper random "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"
# qs -p /home/fboulay/workspace/noctalia-shell/ ipc call wallpaper random "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"
qs -p /home/fboulay/workspace/noctalia-shell/ ipc call wallpaper random

