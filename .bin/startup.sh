#!/bin/sh

if  [ $DESKTOP_SESSION = "dwm" ] then;
        sxhkd &
        picom &
        nitrogen --restore &
        dwmblocks &
        unclutter &
fi
discord &
unclutter --idle 2.5 &
protonmail-bridge --noninteractive &
emacs --daemon &
autoscroll-enabled &
deluge &
