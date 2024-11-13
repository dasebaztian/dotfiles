#!/usr/bin/bash

killall -q polybar

echo "---" | tee -a /tmp/polybarball.log

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload all &
  done
else
  polybar --reload all 2>&1 | tee -a /tmp/polybarall.log & disown
  polybar hour 2>&1 | tee -a /tmp/polybarhour.log & disown
  
fi




echo "Bar Launched..."

