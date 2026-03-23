#!/bin/bash

# -------- Cleanup function --------
cleanup() {
    powerprofilesctl set power-saver
}
trap cleanup EXIT SIGINT SIGTERM

# -------- CPU / Power --------
powerprofilesctl set performance

# -------- Launch game --------
MANGOHUD=1 gamemoderun gamescope \
    -w 2560 -h 1440 -r 120 -o 120 -f \
    --adaptive-sync \
    --immediate-flips \
    --force-grab-cursor \
    --rt \
    --framerate-limit 87 \
    -- \
    env \
    MANGOHUD_CONFIG="fps_limit=87,no_display" \
    DXVK_ASYNC=1 \
    ENABLE_LAYER_MESA_ANTI_LAG=1 \
    "$@"
