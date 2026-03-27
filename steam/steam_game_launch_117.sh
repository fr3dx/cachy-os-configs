#!/bin/bash

# LAVD powersave default, switch to performance for this session

cleanup() {
    # Restore powersave profile and LAVD
    powerprofilesctl set power-saver
    sudo systemctl stop scx_lavd-performance.service
    sudo systemctl start scx_lavd-powersave.service
}
trap cleanup EXIT SIGINT SIGTERM

# Enable performance profile and scheduler
powerprofilesctl set performance
sudo systemctl stop scx_lavd-powersave.service
sudo systemctl start scx_lavd-performance.service

# Launch Gamescope with Proton + DXVK + MangoHud
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
    "$@"

