#!/bin/bash

# LAVD powersave default, switch to performance for this session

cleanup() {
    # Restore powersave profile
    powerprofilesctl set power-saver

    sudo systemctl stop scx_lavd-performance.service
    sudo systemctl stop scx_lavd-powersave.service
    sudo systemctl start scx_lavd-powersave.service
}

trap cleanup EXIT SIGINT SIGTERM

# Enable performance profile
powerprofilesctl set performance

sudo systemctl stop scx_lavd-performance.service
sudo systemctl stop scx_lavd-powersave.service
sudo systemctl start scx_lavd-performance.service

# Launch Gamescope with Proton + DXVK + MangoHud
gamescope \
    -w 2560 -h 1440 -r 120 -f \
    --adaptive-sync \
    --force-grab-cursor \
    -- \
    env \
    DXVK_FRAME_RATE=117 \
    MANGOHUD=1 \
    MANGOHUD_CONFIG="read_cfg" \
    "$@"

