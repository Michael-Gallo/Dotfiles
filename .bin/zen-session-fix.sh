#!/bin/bash
# Stop Zen (flatpak) from restoring every window after an unclean shutdown.
# A reboot kills Zen without a clean exit, so crash recovery (resume_from_crash,
# default true) replays the whole previous session on next launch: multiple windows.
# The pref is written to each profile's user.js, which Zen re-applies at every
# startup regardless of whether it was running during setup. See notes.md.

set -euo pipefail

zen_root=$HOME/.var/app/app.zen_browser.zen/.zen
pref='user_pref("browser.sessionstore.resume_from_crash", false);'

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

    if [ -f "$user_js" ] && grep -qF 'browser.sessionstore.resume_from_crash' "$user_js"; then
        sed -i 's|user_pref("browser.sessionstore.resume_from_crash".*|'"$pref"'|' "$user_js"
        echo "$profile_name: pref already set in user.js"
    else
        [ -f "$user_js" ] || printf '# Managed by ~/.bin/zen-session-fix.sh\n' > "$user_js"
        printf '%s\n' "$pref" >> "$user_js"
        echo "$profile_name: disabled crash-recovery session restore in user.js"
    fi
done

if [ "$found" -eq 0 ]; then
    echo "No Zen profiles found; re-run ~/.bin/zen-session-fix.sh after first launch"
    exit 0
fi

if pgrep -x zen >/dev/null 2>&1; then
    echo "Zen is running; the pref applies on its next launch"
fi
