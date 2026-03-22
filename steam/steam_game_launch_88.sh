#!/bin/bash

cleanup() {
    powerprofilesctl set power-saver
}
trap cleanup EXIT SIGINT SIGTERM

powerprofilesctl set performance

MANGOHUD=1 gamemoderun gamescope \
    -w 2560 -h 1440 -r 120 -o 120 -f \
    --adaptive-sync \
    --immediate-flips \
    --force-grab-cursor \
    -- \
    env \
    MANGOHUD_CONFIG="fps_limit=86,no_display" \
    PROTON_USE_NTSYNC=1 \
    ENABLE_LAYER_MESA_ANTI_LAG=1 \
    "$@"
