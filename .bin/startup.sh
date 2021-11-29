#!/bin/sh



discord &
# protonmail-bridge --noninteractive &
emacs --daemon &
deluge &

case $XDG_SESSION_TYPE in
        "xorg")
                unclutter --idle 2.5 &
                autoscroll-enabled &
esac

case $DESKTOP_SESSION in

        "dwm")
        sxhkd &
        picom &
        nitrogen --restore &
        dwmblocks &
        unclutter &
        systemctl --user start xdg-desktop-portal &
        dunst &
        ;;

        "dwl")
        swaybg -i $XDG_PICTURES_DIR/wallpapers/wallpaper &
        somebar &
        dunst &
        ;;
esac

