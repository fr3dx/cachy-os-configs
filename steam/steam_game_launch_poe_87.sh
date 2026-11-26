#!/bin/bash

###################
# Path of Exile 2 #
###################

# Power profile function
switch_lavd() {
    sudo systemctl stop scx_lavd-$1.service 2>/dev/null
    sudo systemctl start scx_lavd-$2.service 2>/dev/null
}

# Closing game -> Switch to powersave profile
cleanup() {
    powerprofilesctl set power-saver 2>/dev/null
    switch_lavd "performance" "powersave"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# Starting game -> Switch to performance profile
powerprofilesctl set performance 2>/dev/null
switch_lavd "powersave" "performance"

# Launch MangoHud, limit fps
env MANGOHUD=1 \
    MANGOHUD_CONFIG="fps_limit=87,read_cfg" \
    "$@"
