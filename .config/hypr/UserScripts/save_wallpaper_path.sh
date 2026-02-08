#!/usr/bin/env bash
# Save wallpaper path, to use with hyprlock
# $1 : wallpaper path
# $2 : screen name

if [[ $# == 0 ]]; then
    echo "usage: $0 [wallpaper_path] [screen_name]" >&2
    exit 1
fi

if [[ ! -e $1 ]]; then
    echo "wallpaper path [$1] does not exist" >&2
    exit 2
fi

wallpaper_file=/home/fboulay/.config/hypr/wallpaper_effects/.wallpaper_current
if [[ -L $wallpaper_file ]]; then
    # Update file if already a symbolic link
    ln -fs "$1" "$wallpaper_file"
else
    # All other cases, delete the file and re-create it
    rm -f "$wallpaper_file"
    ln -s "$1" "$wallpaper_file"
fi

