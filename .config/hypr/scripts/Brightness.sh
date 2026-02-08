#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Monitor backlights (if supported) using brightnessctl

iDIR="$HOME/.config/swaync/icons"
notification_timeout=1000
step=10  # INCREASE/DECREASE BY THIS VALUE

ddcutil_cache_file="$HOME/.cache/.ddcutil_bus"

# Get brightness
get_backlight() {
	brightnessctl -m | cut -d, -f4 | sed 's/%//'
}


get_backlight_display() {
	ddcutil -b "$1" getvcp 10 --brief | cut -d " " -f4
}

get_bus_id_external_display() {
	# Either read the bus from the cache file, or directly from ddcutil
	if [ -f "$ddcutil_cache_file" ] ; then
		bus_id=$(grep "$1" "$ddcutil_cache_file" | cut -d "," -f 2)
	fi

	if [ -z "$bus_id" ] ; then
		ddcutil detect --brief | grep -A1 "$1" | grep bus | cut -d "-" -f 2
	else
		echo "$bus_id"
	fi
}

# Get icons
get_icon() {
	current=$1
	if   [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-20.png"
	elif [ "$current" -le "40" ]; then
		icon="$iDIR/brightness-40.png"
	elif [ "$current" -le "60" ]; then
		icon="$iDIR/brightness-60.png"
	elif [ "$current" -le "80" ]; then
		icon="$iDIR/brightness-80.png"
	else
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	title="$1"
	notify-send -e -h string:x-canonical-private-synchronous:brightness_notif_"$title" -h int:value:"$current" -u low -i "$icon" "$title" "Brightness:$current%"
}

# Change brightness
change_backlight() {
	local current_brightness
	local current_brightness_display1
	current_brightness=$(get_backlight)
	bus_display1=$(get_bus_id_external_display "Display 1")

	if [ -n "$bus_display1" ] ; then
		current_brightness_display1=$(get_backlight_display "$bus_display1")
	fi

	# Calculate new brightness
	if [[ "$1" == "+${step}%" ]]; then
		new_brightness=$((current_brightness + step))
	elif [[ "$1" == "${step}%-" ]]; then
		new_brightness=$((current_brightness - step))
	fi

	if [ -n "$bus_display1" ] ; then
		if [[ "$1" == "+${step}%" ]]; then
			new_brightness_display1=$((current_brightness_display1 + step))
		elif [[ "$1" == "${step}%-" ]]; then
			new_brightness_display1=$((current_brightness_display1 - step))
		fi
	fi

	# Ensure new brightness is within valid range
	if (( new_brightness < 5 )); then
		new_brightness=5
	elif (( new_brightness > 100 )); then
		new_brightness=100
	fi

	if [ -n "$bus_display1" ] ; then
		if (( new_brightness_display1 < 5 )); then
			new_brightness_display1=5
		elif (( new_brightness_display1 > 100 )); then
			new_brightness_display1=100
		fi
	fi

	# Laptop screen
	brightnessctl set "${new_brightness}%"
	get_icon "$current_brightness"
	current=$new_brightness
	notify_user "Internal screen"

	# External monitor
	if [ -n "$bus_display1" ] ; then
		ddcutil -b "$bus_display1" setvcp 10 "${new_brightness_display1}" &
		get_icon "$current_brightness_display1"
		current=$new_brightness_display1
		notify_user "External monitor"
	fi
}

# Execute accordingly
case "$1" in
	"--get")
		get_backlight
		;;
	"--inc")
		change_backlight "+${step}%"
		;;
	"--dec")
		change_backlight "${step}%-"
		;;
	*)
		get_backlight
		;;
esac
