#!/usr/bin/env bash
function run {
  if ! pgrep -f $1 ;
  then
    run $@&
  fi
}
sxhkd & 
nitrogen --restore &
picom &
discord &
mbsync -a & 
blueman-applet &
pasystray &
nm-applet &
unclutter -idle 5 &
deluge
