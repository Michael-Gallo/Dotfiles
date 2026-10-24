#!/usr/bin/env sh

choice=$(printf "No\nYes" | noctalia dmenu -p "${1:-Confirm?}")

[ "$choice" = "Yes" ] && shift && exec "$@"
