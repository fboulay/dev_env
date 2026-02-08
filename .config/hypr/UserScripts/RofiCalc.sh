#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */
# /* Calculator (using qalculate) and rofi */
# /* Submitted by: https://github.com/JosephArmas */

rofi_theme="$HOME/.config/rofi/config-calc.rasi"

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi

# main function

while true; do
    user_input=$(
        rofi -i -dmenu \
            -config "$rofi_theme" \
            -mesg "$user_input_modified      =    $calc_result"
    )

    if [ $? -ne 0 ]; then
        exit
    fi

    if [ -n "$user_input" ]; then
        # allow to use the word `res` to reuse the result of the previous calculation
        user_input_modified="${user_input/res/${calc_result}}"
        calc_result=$(qalc -t "$user_input_modified")
        echo "$calc_result" | wl-copy
    fi
done
