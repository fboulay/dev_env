#!/usr/bin/env bash
# Change the resolution of the current connected monitor

monitor_conf_file=$HOME/.config/hypr/monitors.conf

monitor_desc=$(hyprctl monitors -j | jq -r '.[] | select(.name == "DP-1") | .description')

# Home monitor
if [[ "$monitor_desc" == *"GWD ARZOPA"*  ]] ; then
    echo "Home monitor detected"
    conf_monitor="monitor=DP-1,1920x1080@120.0,640x0,1.0"
fi

# Electre Monitor
if [[ "$monitor_desc" == *"LG Electronics LG HDR 4K"*  ]] ; then
    echo "Electre monitor detected"
    conf_monitor="monitor=DP-1,2560x1440@59.95,0x0,1.0"
fi

if [ -n "$conf_monitor" ] ; then
    if grep -q "$conf_monitor" "$monitor_conf_file" ; then
        echo "No configuration change needed"
    else
        sed -i "/=DP-1/c\\${conf_monitor}" "$monitor_conf_file"
        echo "Configuration changed"
    fi
fi
