#!/bin/bash

############################
# Splitgate Arena Reloaded #
############################

# LAVD scheduler mode function
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

# Launch MangoHud. Do not forget to limit fps ingame -> 115-119!
env MANGOHUD=1 \
    MANGOHUD_CONFIG="read_cfg,af=16" \
    "$@"
