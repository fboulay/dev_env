#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Screenshots scripts
# variables
time=$(date "+%d-%b_%H-%M-%S")
dir="$(xdg-user-dir)/Pictures/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"

iDIR="$HOME/.config/swaync/icons"
iDoR="$HOME/.config/swaync/images"
sDIR="$HOME/.config/hypr/scripts"

active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
active_window_file="Screenshot_${time}_${active_window_class}.png"
active_window_path="${dir}/${active_window_file}"

notify_cmd_base="notify-send -t 10000 -A action1=Open -A action2=Delete -h string:x-canonical-private-synchronous:shot-notify"
notify_cmd_shot="${notify_cmd_base} -i ${iDIR}/picture.png "
notify_cmd_shot_win="${notify_cmd_base} -i ${iDIR}/picture.png "
notify_cmd_NOT="notify-send -u low -i ${iDoR}/note.png "

# default screenshot command to use
screenshot_utility=grim
screenshot_command=""
debug=

# notify and view screenshot
notify_view() {
    if [[ "$1" == "active" ]]; then
        if [[ -e "${active_window_path}" ]]; then
			"${sDIR}/Sounds.sh" --screenshot        
            resp=$(timeout 5 ${notify_cmd_shot_win} " Screenshot of:" " ${active_window_class} Saved.")
            case "$resp" in
				action1)
					xdg-open "${active_window_path}" &
					;;
				action2)
					rm "${active_window_path}" &
					;;
			esac
        else
            ${notify_cmd_NOT} " Screenshot of:" " ${active_window_class} NOT Saved."
            "${sDIR}/Sounds.sh" --error
        fi

    elif [[ "$1" == "swappy" ]]; then
		"${sDIR}/Sounds.sh" --screenshot
		resp=$(${notify_cmd_shot} " Screenshot:" " Captured by Swappy")
		case "$resp" in
			action1)
				swappy -f - <"$tmpfile"
				;;
			action2)
				rm "$tmpfile"
				;;
		esac

    else
        local check_file="${dir}/${file}"
        if [[ -e "$check_file" ]]; then
            "${sDIR}/Sounds.sh" --screenshot
            resp=$(timeout 5 ${notify_cmd_shot} " Screenshot" " Saved")
			case "$resp" in
				action1)
					xdg-open "${check_file}" &
					;;
				action2)
					rm "${check_file}" &
					;;
			esac
        else
            ${notify_cmd_NOT} " Screenshot" " NOT Saved"
            "${sDIR}/Sounds.sh" --error
        fi
    fi
}

# countdown
countdown() {
	for sec in $(seq $1 -1 1); do
		notify-send -h string:x-canonical-private-synchronous:shot-notify -t 1000 -i "$iDIR"/timer.png  " Taking shot" " in: $sec secs"
		sleep 1
	done
}

# take shots
# shotnow() {
# 	cd ${dir} && grim - | tee "$file" | wl-copy
# 	sleep 2
# 	notify_view
# }

# shot5() {
# 	countdown '5'
# 	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
# 	sleep 1
# 	notify_view
# }

# shot10() {
# 	countdown '10'
# 	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
# 	notify_view
# }

# shotwin() {
# 	w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
# 	w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
# 	cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
# 	notify_view
# }

# shotarea() {
# 	tmpfile=$(mktemp)
# 	grim -g "$(slurp)" - >"$tmpfile"

#   # Copy with saving
# 	if [[ -s "$tmpfile" ]]; then
# 		wl-copy <"$tmpfile"
# 		mv "$tmpfile" "$dir/$file"
# 	fi
# 	notify_view
# }

# shotactive() {
#     active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
#     active_window_file="Screenshot_${time}_${active_window_class}.png"
#     active_window_path="${dir}/${active_window_file}"

#     hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "${active_window_path}"
# 	sleep 1
#     notify_view "active"
# }

# shotswappy() {
# 	tmpfile=$(mktemp)
# 	grim -g "$(slurp)" - >"$tmpfile"

#   # Copy without saving
#   if [[ -s "$tmpfile" ]]; then
# 		wl-copy <"$tmpfile"
#     notify_view "swappy"
#   fi
# }

# shotsatty() {
# 	tmpfile=$(mktemp)
#     grim -g "$(slurp -c '#ff0000ff' -w 5)" -t ppm - > "$tmpfile"
#     "${sDIR}/Sounds.sh" --screenshot
#     satty --filename "$tmpfile" --fullscreen --output-filename "${dir}/${file}"
#     rm "$tmpfile"
# }

## Create a region screenshot, store it in a file, and return the path to the file
mk_region_file() {
	tmpfile=$(mktemp)
    grim -g "$(slurp -c '#ff0000ff' -w 5)" -t ppm - > "$tmpfile"
    echo "$tmpfile"
}

## Create a screenshot of the active window, store it in a file, and return the path to the file
mk_active_window_file() {
	w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
	w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
	tmpfile=$(mktemp)
    grim -g "$w_pos $w_size" -t ppm  - > "$tmpfile"
    echo "$tmpfile"
}

## Create a whole desktop screenshot, store it in a file, and return the path to the file
mk_desktop_file() {
	tmpfile=$(mktemp)
    grim -t ppm - > "$tmpfile"
    echo "$tmpfile"
}

open_file_satty() {
    satty --filename "$1" --fullscreen --output-filename "${dir}/${file}"
   [ -e "$1" ] && rm "$1"
}

open_file_swappy() {
    swappy --file "$1" --output-file "${dir}/${file}"
    [ -e "$1" ] && rm "$1"
}

store_file() {
    magick "$1" "${dir}/${file}"
    [ -e "$1" ] && rm "$1"
}

screenshot_sound() {
    "${sDIR}/Sounds.sh" --screenshot
}

screenshot_cancel() {
    ${notify_cmd_NOT} " Screenshot" " NOT Saved"
    "${sDIR}/Sounds.sh" --error
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# Parsing args
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --desktop)
        screenshot_zone=desktop
        ;;
    --in5)
        delay_screenshot=5
        ;;
    --in)
        delay_screenshot=10
        ;;
    --satty|--swappy|--grim)
        screenshot_utility=${1:2} ## remove the first 2 characters of the $1 variable
        ;;
    --area)
        screenshot_zone=area
        ;;
    --active|--win)
        screenshot_zone=window
        ;;
    --debug)
        debug=1
        ;;
    -h|--help|*)
        echo "Usage: $0 [options]"
        echo "Available options :"
        echo -e "\t--swappy|--satty|--grim  Choose the screenshot tool to use. Default : grim"
        echo -e "\t--in5|--in10             Take a screenshot with a 5 seconds or 10 seconds delay. Default : 0 second"
        echo -e "\t--desktop                Take a screenshot of the whole desktop"
        echo -e "\t--area                   Take a screenshot using an area"
        echo -e "\t--active                 Take a screenshot of the current active window"
        exit 1
        ;;
  esac
  shift || break
done

if [ -n "$debug" ]; then
    echo "screenshot zone :  $screenshot_zone"
    echo "screenshot delay : $delay_screenshot"
    echo "screenshot tool :  $screenshot_utility"
fi

# Creating command to run
case $delay_screenshot in
    5)
        screenshot_command="countdown 5 &&"
        ;;
    10)
        screenshot_command="countdown 10 &&"
        ;;
esac

case $screenshot_zone in
    window)
        image_file_path="$(mk_active_window_file)"
        ;;
    area)
        image_file_path="$(mk_region_file)"
        ;;
    desktop)
        image_file_path="$(mk_desktop_file)"
        ;;
esac

if [ ! -s "$image_file_path" ]; then
    screenshot_cancel
else
    case $screenshot_utility in
        grim)
            screenshot_command="$screenshot_command store_file $image_file_path && notify_view"
            ;;
        satty)
            screenshot_command="$screenshot_command screenshot_sound && open_file_satty $image_file_path"
            ;;
        swappy)
            screenshot_command="$screenshot_command screenshot_sound && open_file_swappy $image_file_path"
            ;;
    esac
fi


[ -n "$debug" ] && echo "command to execute : ${screenshot_command}"

eval "${screenshot_command}"

# Try to delete the tmp file if it still exists
[ -e "$tmpfile" ] && rm "$tmpfile"

# if [[ "$1" == "--now" ]]; then
# 	shotnow
# elif [[ "$1" == "--in5" ]]; then
# 	shot5
# elif [[ "$1" == "--in10" ]]; then
# 	shot10
# elif [[ "$1" == "--win" ]]; then
# 	shotwin
# elif [[ "$1" == "--area" ]]; then
# 	shotarea
# elif [[ "$1" == "--active" ]]; then
# 	shotactive
# elif [[ "$1" == "--swappy" ]]; then
# 	shotswappy
# elif [[ "$1" == "--satty" ]]; then
# 	shotsatty
# else
# 	echo -e "Available Options : --now --in5 --in10 --win --area --active --swappy --satty"
# fi

exit 0
