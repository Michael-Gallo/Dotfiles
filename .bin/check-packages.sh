#!/bin/sh
set -e

yadm_dir="$HOME/.config/yadm"
pacman_missing=""
aur_missing=""
flatpak_missing=""

read_pkgs() {
    [ -f "$1" ] || return
    grep -vE '^\s*$|^\s*#' "$1"
}

check_pacman_aur() {
    pacman_pkgs=$(read_pkgs "$yadm_dir/pacman.txt")
    aur_pkgs=$(read_pkgs "$yadm_dir/aur.txt")
    all_pkgs="$pacman_pkgs $aur_pkgs"
    [ -z "$(echo "$all_pkgs" | tr -d ' ')" ] && return

    unsatisfied=$(pacman -T $all_pkgs 2>/dev/null) || true
    for pkg in $unsatisfied; do
        if pacman -Qg "$pkg" >/dev/null 2>&1; then
            continue
        fi
        if echo "$aur_pkgs" | grep -qw "$pkg"; then
            aur_missing="$aur_missing $pkg"
        else
            pacman_missing="$pacman_missing $pkg"
        fi
    done
}

check_flatpaks() {
    [ -f "$yadm_dir/flatpaks.txt" ] || return
    installed_flatpaks=$(flatpak list --app --columns=application 2>/dev/null || true)
    while IFS= read -r pkg; do
        [ -z "$pkg" ] || [ "#*" = "$pkg" ] && continue
        echo "$installed_flatpaks" | grep -qx "$pkg" || flatpak_missing="$flatpak_missing $pkg"
    done < "$yadm_dir/flatpaks.txt"
}

check_pacman_aur
check_flatpaks

if [ -z "$pacman_missing" ] && [ -z "$aur_missing" ] && [ -z "$flatpak_missing" ]; then
    echo "All packages installed"
    exit 0
fi

echo "Missing packages:"
[ -n "$pacman_missing" ] && echo "  pacman:$pacman_missing"
[ -n "$aur_missing" ] && echo "  aur:$aur_missing"
[ -n "$flatpak_missing" ] && echo "  flatpak:$flatpak_missing"
echo ""

prompt_install() {
    label="$1"
    pkgs="$2"
    cmd="$3"
    if [ -z "$pkgs" ]; then
        return
    fi
    printf "Install %s packages? [%s]\n(y/n/a=all): " "$label" "$pkgs"
    read -r answer
    case "$answer" in
        y|Y)
            $cmd $pkgs
            ;;
        a|A)
            sudo pacman -S --needed $pacman_missing
            paru -S --needed $aur_missing
            flatpak install $flatpak_missing
            exit 0
            ;;
        *)
            echo "Skipping $label"
            ;;
    esac
}

prompt_install "pacman" "$pacman_missing" "sudo pacman -S --needed"
prompt_install "AUR" "$aur_missing" "paru -S --needed"
prompt_install "flatpak" "$flatpak_missing" "flatpak install"