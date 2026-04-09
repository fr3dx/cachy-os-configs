#!/bin/bash

############################
# Splitgate Arena Reloaded #
############################

# scx_lavd scheduler mode function
switch_lavd() {
    sudo systemctl stop scx_lavd-$1.service 2>/dev/null
    sudo systemctl start scx_lavd-$2.service 2>/dev/null
}

# Closing game -> Switch to powersave mode
cleanup() {
    powerprofilesctl set power-saver 2>/dev/null
    switch_lavd "performance" "powersave"
}

trap cleanup EXIT SIGINT SIGTERM

# Starting game -> Switch to performance mode
powerprofilesctl set performance 2>/dev/null
switch_lavd "powersave" "performance"

# Launch MangoHud, limit fps
env VKD3D_FRAME_RATE=117 \
    MANGOHUD=1 \
    MANGOHUD_CONFIG="read_cfg,af=16" \
    "$@"

