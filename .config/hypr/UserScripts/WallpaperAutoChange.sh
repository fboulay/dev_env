#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# source https://wiki.archlinux.org/title/Hyprland#Using_a_script_to_change_wallpaper_every_X_minutes

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script uses bash (not POSIX shell) for the RANDOM variable

# This controls (in seconds) when to switch to the next image
INTERVAL=1800

while true; do
	"$HOME/.config/hypr/UserScripts/WallpaperRandom.sh" nowaybar
	sleep $INTERVAL
done
