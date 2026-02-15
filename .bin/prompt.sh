#!/usr/bin/env sh

choice=$(printf "No\nYes" | rofi -dmenu \
  -i \
  -no-custom \
  -p "${1:-Confirm?}" \
  -theme-str '
    window { width: 22%; location: center; }
    listview { lines: 2; }
  ')

[ "$choice" = "Yes" ] && shift && exec "$@"
