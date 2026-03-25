#!/bin/bash

cleanup() {
    powerprofilesctl set power-saver
}
trap cleanup EXIT SIGINT SIGTERM

powerprofilesctl set performance

MANGOHUD=1 gamemoderun env \
    RADV_FORCE_ANISO=16 \
    DXVK_FRAME_RATE=117 \
    MANGOHUD_CONFIG="no_display" \
    PROTON_USE_NTSYNC=1 \
    ENABLE_LAYER_MESA_ANTI_LAG=1 \
    gamescope \
        -w 2560 -h 1440 -r 120 -o 120 -f \
        --adaptive-sync \
        --immediate-flips \
        --force-grab-cursor \
        --rt \
        -- \
        "$@"

