#!/usr/bin/env sh

choice=$(printf "No\nYes" | rofi -dmenu \
  -i \
  -p "${1:-Confirm?}" \
  -lines 2 \
  -width 20 \
  -theme-str 'window {width: 20%;} listview {lines: 2;}')

[ "$choice" = "Yes" ] && shift && exec "$@"
