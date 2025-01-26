#!/bin/bash

# Get the active monitor's ID
ACTIVE_MONITOR_ID=$(hyprctl activeworkspace -j | jq -r '.monitorID')

# Calculate the workspace number
WORKSPACE=$(( $ACTIVE_MONITOR_ID * 5 + $1 ))


if [ "$2" == "move" ]; then
    # Move the focused window to the calculated workspace
    hyprctl dispatch movetoworkspace "$WORKSPACE"
else
    # Switch to the calculated workspace
    hyprctl dispatch workspace "$WORKSPACE"
fi
