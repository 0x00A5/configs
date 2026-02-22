#!/usr/bin/env bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.3; done

#for m in $(polybar --list-monitors | cut -d":" -f1); do
#  MONITOR=$m polybar main &
polybar main &
#done

