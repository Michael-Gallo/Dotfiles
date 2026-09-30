# Setup notes

Why this machine is configured the way it is — the non-obvious fixes that would
otherwise need re-diagnosing after a fresh setup. The bootstrap prints this file
when it runs; add new entries here as quirks get solved.

## Zen restores every window after a reboot

Rebooting kills Zen without a clean exit, so its crash recovery replays the
entire previous session on next launch (every window, regardless of the
"Open previous windows and tabs" setting). Fixed by pinning
`browser.sessionstore.resume_from_crash` to `false` in each profile's
`user.js`, applied idempotently by `~/.bin/zen-session-fix.sh` (the bootstrap
runs it after installing flatpaks).

To revert, delete the pref line from
`~/.var/app/app.zen_browser.zen/.zen/*/user.js`. To get a lost session back
after a crash, use History -> Restore Previous Session.

## waybar is on the AUR git package

Installed as `waybar-git` because waybar 0.15.x doesn't support Hyprland
0.55's Lua IPC protocol (workspace clicks break). Switch back to mainline
once waybar 0.16+ releases.
