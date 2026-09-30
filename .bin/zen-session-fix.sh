#!/bin/bash
# Stop Zen (flatpak) from reopening your old windows:
# - A reboot kills Zen without a clean exit, so crash recovery (resume_from_crash,
#   default true) replays the whole previous session on next launch.
# - Window Sync (v1.18b+) makes every window mirror the same tab list; off keeps
#   windows independent.
# Prefs are written to each profile's user.js, which Zen re-applies at every
# startup regardless of whether it was running during setup.

set -euo pipefail

zen_root=$HOME/.var/app/app.zen_browser.zen/.zen

prefs=(
    'user_pref("browser.sessionstore.resume_from_crash", false);'
    'user_pref("zen.window-sync.enabled", false);'
)

if [ ! -d "$zen_root" ]; then
    echo "Zen not installed or never launched; re-run ~/.bin/zen-session-fix.sh after first launch"
    exit 0
fi

found=0
for profile_dir in "$zen_root"/*/; do
    [ -f "$profile_dir/prefs.js" ] || continue
    found=1
    profile_name=$(basename "$profile_dir")
    user_js="$profile_dir/user.js"
    [ -f "$user_js" ] || printf '# Managed by ~/.bin/zen-session-fix.sh\n' > "$user_js"

    for pref in "${prefs[@]}"; do
        pref_name=$(grep -oP 'user_pref\("\K[^"]+' <<< "$pref")
        if grep -qF "\"$pref_name\"" "$user_js"; then
            sed -i 's|user_pref("'"$pref_name"'".*|'"$pref"'|' "$user_js"
        else
            printf '%s\n' "$pref" >> "$user_js"
        fi
        echo "$profile_name: $pref_name pinned in user.js"
    done
done

if [ "$found" -eq 0 ]; then
    echo "No Zen profiles found; re-run ~/.bin/zen-session-fix.sh after first launch"
    exit 0
fi

if pgrep -x zen >/dev/null 2>&1; then
    echo "Zen is running; the prefs apply on its next launch"
fi
