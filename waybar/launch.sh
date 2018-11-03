#!/usr/bin/bash

# Terminate already running bar instances
killall -q waybar

# Launch bar
waybar

echo "Bars launched..."
