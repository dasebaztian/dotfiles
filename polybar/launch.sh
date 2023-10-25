#!/usr/bin/bash

killall -q polybar

echo "---" | tee -a /tmp/polybarbackground.log
echo "---" | tee -a /tmp/polybarworkspaces.log
echo "---" | tee -a /tmp/polybarstatus.log
echo "---" | tee -a /tmp/polybarinfo.log
echo "---" | tee -a /tmp/polybarweather.log
echo "---" | tee -a /tmp/polybarnotion.log

polybar background 2>&1 | tee -a /tmp/polybarbackground.log & disown
polybar workspaces 2>&1 | tee -a /tmp/polybarworkspaces.log & disown
polybar status 2>&1 | tee -a /tmp/polybarstatus.log & disown
polybar info 2>&1 | tee -a /tmp/polybarinfo.log & disown
polybar weather 2>&1 | tee -a /tmp/polybarweather.log & disown
polybar notion 2>&1 | tee -a /tmp/polybarnotion.log & disown




echo "Bar Launched..."
