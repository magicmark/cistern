#!/bin/bash
status=$(/usr/bin/acpi -b)
percent=$(echo "$status" | grep -o "[0-9]\{1,3\}%" | tr -d '%')

if [[ "$status" == *'Discharging'* ]]; then
    if [[ "$percent" -lt 20 ]]; then
        notify-send \
            -u critical \
            -c battery \
            "Battery is Low!" \
            "Charge me otherwise I will die :("
    fi
fi
