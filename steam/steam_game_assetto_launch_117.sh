#!/bin/bash

#######################
# Assetto Corsa Rally #
#######################

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

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# Starting game -> Switch to performance mode
powerprofilesctl set performance 2>/dev/null
switch_lavd "powersave" "performance"

# Enable MangoHud and VKD3D low latency, cap FPS at 87.
env \
    DISABLE_LOW_LATENCY_LAYER=1 \
    PROTON_VKD3D_LOWLATENCY=1 \
    VKD3D_FRAME_RATE=87 \
    MANGOHUD=1 \
    MANGOHUD_CONFIG="read_cfg" \
    "$@"

