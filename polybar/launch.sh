#!/usr/bin/bash

killall -q polybar

echo "---" | tee -a /tmp/polybarball.log


polybar all 2>&1 | tee -a /tmp/polybarall.log & disown





echo "Bar Launched..."
