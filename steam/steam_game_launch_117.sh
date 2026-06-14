#!/bin/bash

########################################
# Fr3dx's default competitive settings #
########################################

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

# Launch the game with MangoHud, enable low_latency_layer, limit fps to 117.
env \
    LOW_LATENCY_LAYER=1 \
    LOW_LATENCY_LAYER_REFLEX=1 \
    VKD3D_FRAME_RATE=117 \
    MANGOHUD=0 \
    MANGOHUD_CONFIG="read_cfg" \
    "$@"

