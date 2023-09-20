#!/usr/bin/bash

killall -q polybar

echo "---" | tee -a /tmp/polybar1.log
echo "---" | tee -a /tmp/polybar2.log

polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bar Launched..."
