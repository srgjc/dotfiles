#!/usr/bin/env bash

INTERNAL="eDP-1"

ENABLED_MONITORS=$(hyprctl monitors | grep -c "Monitor")

if hyprctl monitors | grep -q "^Monitor $INTERNAL"; then
    INTERNAL_ACTIVE=1
else
    INTERNAL_ACTIVE=0
fi

if [ "$INTERNAL_ACTIVE" -eq 1 ]; then
    if [ "$ENABLED_MONITORS" -le 1 ]; then
        notify-send -u low "Display Toggle" "󰍹   Cannot disable the only display"
        exit 1
    else
        hyprctl keyword monitor "$INTERNAL,disable"
        notify-send -u low "Display Toggle" "󰍹   Laptop display disabled"
    fi
else
    hyprctl keyword monitor "$INTERNAL,preferred,auto,auto"
    notify-send -u low "Display Toggle" "󰍹   Laptop display enabled"
fi
