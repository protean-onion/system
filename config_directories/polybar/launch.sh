#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar
# Kill previous bars
killall -q polybar

# ipc enabled quitting
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar main &