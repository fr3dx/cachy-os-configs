#!/bin/bash

cleanup() {
    powerprofilesctl set power-saver
}
trap cleanup EXIT SIGINT SIGTERM

powerprofilesctl set performance

gamescope \
    -w 2560 -h 1440 -r 120 -f \
    --adaptive-sync \
    --immediate-flips \
    --force-grab-cursor \
    --rt \
    -- \
    gamemoderun env \
    DXVK_FRAME_RATE=117 \
    MANGOHUD=1 \
    MANGOHUD_CONFIG="read_cfg" \
    PROTON_USE_NTSYNC=1 \
    ENABLE_LAYER_MESA_ANTI_LAG=1 \
    "$@"

