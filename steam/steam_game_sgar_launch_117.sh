# Splitgate Arena Reloaded

#!/bin/bash

# Power profile function
switch_lavd() {
    sudo systemctl stop scx_lavd-$1.service 2>/dev/null
    sudo systemctl start scx_lavd-$2.service 2>/dev/null
}

cleanup() {
    # Closing game -> Switch to powersave profile
    powerprofilesctl set power-saver 2>/dev/null
    switch_lavd "performance" "powersave"
}

trap cleanup EXIT SIGINT SIGTERM

# Starting game -> Switch to performance profile
powerprofilesctl set performance 2>/dev/null
switch_lavd "powersave" "performance"

# Turn on mangohud, limit fps and improve quality
env DXVK_FRAME_RATE=117 \
    MANGOHUD=1 \
    MANGOHUD_CONFIG="read_cfg,fps_limit=117,fps_limit_method=late,af=16,bicubic" \
    "$@"
