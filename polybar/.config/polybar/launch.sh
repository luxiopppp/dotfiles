#!/bin/bash

# Terminate already running bar instances
polybar-msg cmd quit

# Launch Polybar, using default config location
echo "---" | tee -a /tmp/polybar.log
polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

# Multiple monitor
if [[ $(xrandr -q | grep 'HDMI1 connected') ]]; then
	polybar external &
fi

echo "Polybar launched..."
