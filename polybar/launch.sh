#!/usr/bin/bash

killall -q polybar

echo "---" | tee -a /tmp/polybarbackground.log
echo "---" | tee -a /tmp/polybarball.log


polybar background 2>&1 | tee -a /tmp/polybarbackground.log & disown
polybar all 2>&1 | tee -a /tmp/polybarbackground.log & disown





echo "Bar Launched..."
