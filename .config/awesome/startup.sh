#!/usr/bin/env bash
function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}
run sxhkd & 
run nitrogen --restore &
run picom &
run discord &
run mbsync -a & 
run blueman-applet &
run pasystray &
run nm-applet &
