#!/usr/bin/env bash
# Listen to monitor changes, and run actions accordingly (eg resolution changes)


udevadm monitor --subsystem-match=drm | while read -r line; do
    if echo "$line" | grep "change" | grep -q "UDEV" ; then
        echo "Monitor configuration changed"
        "$HOME"/.config/hypr/UserScripts/ChangeMonitors.sh
        "$HOME"/.config/hypr/UserScripts/ReadMonitorBus.sh
    fi
done
