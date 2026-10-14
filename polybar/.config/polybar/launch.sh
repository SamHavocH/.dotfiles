#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, one instance per connected monitor
for m in $(xrandr --query | grep " connected" | cut -d ' ' -f1); do
    MONITOR=$m polybar main --config=~/.config/polybar/config.ini &
done

echo "Polybar launched..."