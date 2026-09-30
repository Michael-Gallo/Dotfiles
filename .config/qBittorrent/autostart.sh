#!/bin/sh
# qBittorrent autostart wrapper.
#
# The "Window state on start: Hidden" setting only applies when a tray is
# available at startup. At login, waybar may not have registered
# org.kde.StatusNotifierWatcher yet; if qBittorrent starts before that, it
# assumes there is no tray and shows a window instead of staying hidden.
# Wait for the watcher (max 30 s) before launching.

n=0
while [ "$n" -lt 60 ]; do
    busctl --user list 2>/dev/null | grep -q org.kde.StatusNotifierWatcher && break
    n=$((n + 1))
    sleep 0.5
done

# Give the tray host a moment to settle before qBittorrent checks for it.
sleep 1

exec qbittorrent "$@"
