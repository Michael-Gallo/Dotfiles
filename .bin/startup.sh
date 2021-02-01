#!/bin/bash
sxhkd &
picom &
nitrogen --restore &
discord &
dwmblocks &
unclutter --idle 2.5 &
protonmail-bridge --noninteractive &
emacs --daemon
