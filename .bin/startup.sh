#!/bin/sh




case $XDG_SESSION_TYPE in
        "xorg")
                unclutter --idle 2.5 &
                autoscroll-enabled &
                discord &
        ;;
        "wayland")
                foot --server &
                discord --ozone-platform=wayland &
        ;;
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
        deluged &
        ;;

        "openbox")
                sxhkd &
                picom &
                nitrogen --restore &
                dunst &

        ;;


        "dwl")
        swaybg -i $XDG_PICTURES_DIR/wallpapers/wallpaper &
        swhks & # swhkd server
        somebar &
        someblocks&
        dunst &
        pkexec swhkd -c /home/mike/.config/swhkd/swhkdrc
        ;;
esac

