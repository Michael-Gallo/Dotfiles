#!/usr/bin/env bash
function run {
  if ! pgrep $1 > /dev/null; then
      $@ &
      echo "Ran $@"
  fi
}
start_commands=(
        "sxhkd"
        "picom"
        "blueman-applet"
        "pasystray"
        "nm-applet"
        "unclutter -idle 5"
        "pcmanfm -d"
        "mbsync -a"

)
for command_index in ${!start_commands[@]}; do
        run ${start_commands[$command_index]}
done
sleep .5
nitrogen --restore
sleep 1.5
run discord
run skypeforlinux
