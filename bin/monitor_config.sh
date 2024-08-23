#!/bin/bash
if [[ $(xrandr -q | grep 'HDMI-A-0 connected') ]]; then
    xrandr --output eDP --output HDMI1 --mode 1920x1080 --rotate normal --right-of eDP1
    # Workspaces
    bspc monitor eDP -d 1
    bspc monitor HDMI-A-0 -d 2 3 4
else
    xrandr --output HDMI-A-0 --off
    # Remove nodes
    while bspc node @2: --kill; do
        :
    done
    while bspc node @3: --kill; do
        :
    done
    while bspc node @4: --kill; do
        :
    done
    while bspc node @5: --kill; do
        :
    done
    # Remove workspaces
    bspc desktop -r 1 2 3 4
    # Remove monitor
    bspc monitor HDMI1 -r
    bspc monitor eDP -d 1 2 3 4
fi
