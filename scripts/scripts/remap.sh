#!/bin/bash
export DISPLAY=:0

## Udev should execute this script when it recieves a new input device signal.
echo "$(date): remap.sh script executed" >> /tmp/remap.log

# Swap esc to caps lock
setxkbmap -option caps:swapescape

# Disable auto-lock screen
xset s off
xset -dpms

# Key repeat rate
xset r rate 300 50
