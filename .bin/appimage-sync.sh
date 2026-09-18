#!/bin/bash
# Sync AppImages from ~/.config/yadm/appimages.txt and integrate them with GearLever.
# Re-run to install updates; GearLever manages .desktop entries, icons and old versions.

set -euo pipefail

manifest=$XDG_CONFIG_HOME/yadm/appimages.txt

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT INT TERM

while read -r name url pattern flag; do
    [ -z "$name" ] && continue
    case "$name" in \#*) continue ;; esac

    if [ -n "${pattern:-}" ]; then
        # Resolve the current download URL from a JSON endpoint (\/ escapes cleaned up)
        url=$(curl -fsSL --max-time 30 "$url" | grep -Pom1 "$pattern" | sed 's#\\/#/#g') || true
        if [ -z "$url" ]; then
            echo "$name: could not resolve download URL" >&2
            continue
        fi
    fi

    echo "Downloading $name"
    if ! curl -fsSL --retry 3 -o "$tmpdir/$name.AppImage" "$url"; then
        echo "$name: download failed" >&2
        continue
    fi
    chmod +x "$tmpdir/$name.AppImage"

    # GearLever prompts y/N; yes y answers them. pipefail is off around the
    # pipeline because yes always exits via SIGPIPE when GearLever finishes.
    # "already integrated" counts as success so re-runs are idempotent.
    log=$tmpdir/integrate.log
    set +o pipefail
    yes y 2>/dev/null | flatpak run it.mijorus.gearlever --integrate "$tmpdir/$name.AppImage" >"$log" 2>&1 || true
    set -o pipefail

    if grep -qE 'integrated successfully|already integrated' "$log"; then
        echo "$name: integrated"
        # Apps that self-integrate create their own entries; GearLever's copy
        # would be a duplicate in the app menu
        [ "${flag:-}" = nodektop ] && rm -f "$HOME/.local/share/applications/$name.desktop"
    else
        echo "GearLever integration failed; placing $name in ~/Applications" >&2
        cat "$log" >&2
        install -Dm755 "$tmpdir/$name.AppImage" "$HOME/Applications/$name.AppImage"
    fi
done < "$manifest"
