#!/bin/sh
set -e

yadm_dir="$HOME/.config/yadm"
pacman_pkgs=""
aur_pkgs=""
flatpak_pkgs=""

installed=$(pacman -Qq 2>/dev/null || true)
installed_flatpaks=$(flatpak list --app --columns=application 2>/dev/null || true)

check_pacman() {
    [ -f "$yadm_dir/pacman.txt" ] || return
    while IFS= read -r pkg; do
        [ -z "$pkg" ] || [ "#*" = "$pkg" ] && continue
        echo "$installed" | grep -qx "$pkg" || pacman_pkgs="$pacman_pkgs $pkg"
    done < "$yadm_dir/pacman.txt"
}

check_aur() {
    [ -f "$yadm_dir/aur.txt" ] || return
    while IFS= read -r pkg; do
        [ -z "$pkg" ] || [ "#*" = "$pkg" ] && continue
        echo "$installed" | grep -qx "$pkg" || aur_pkgs="$aur_pkgs $pkg"
    done < "$yadm_dir/aur.txt"
}

check_flatpak() {
    [ -f "$yadm_dir/flatpaks.txt" ] || return
    while IFS= read -r pkg; do
        [ -z "$pkg" ] || [ "#*" = "$pkg" ] && continue
        echo "$installed_flatpaks" | grep -qx "$pkg" || flatpak_pkgs="$flatpak_pkgs $pkg"
    done < "$yadm_dir/flatpaks.txt"
}

check_pacman
check_aur
check_flatpak

if [ -z "$pacman_pkgs" ] && [ -z "$aur_pkgs" ] && [ -z "$flatpak_pkgs" ]; then
    echo "All packages installed"
    exit 0
fi

echo "Missing packages:"
[ -n "$pacman_pkgs" ] && echo "  pacman:$(echo "$pacman_pkgs" | tr '\n' ' ')"
[ -n "$aur_pkgs" ] && echo "  aur:$(echo "$aur_pkgs" | tr '\n' ' ')"
[ -n "$flatpak_pkgs" ] && echo "  flatpak:$(echo "$flatpak_pkgs" | tr '\n' ' ')"
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
            sudo pacman -S --needed $pacman_pkgs
            paru -S --needed $aur_pkgs
            flatpak install $flatpak_pkgs
            exit 0
            ;;
        *)
            echo "Skipping $label"
            ;;
    esac
}

prompt_install "pacman" "$pacman_pkgs" "sudo pacman -S --needed"
prompt_install "AUR" "$aur_pkgs" "paru -S --needed"
prompt_install "flatpak" "$flatpak_pkgs" "flatpak install"