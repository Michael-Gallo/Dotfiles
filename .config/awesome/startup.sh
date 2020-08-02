#!/usr/bin/env bash
function run {
  if ! pgrep $1 > /dev/null; then
      $@ &
      echo "Ran $@"
  fi
}
start_commands=(
        "sxhkd"
        "nitrogen --restore"
        "discord"
        "picom"
        "blueman-applet"
        "pasystray"
        "nm-applet"
        "unclutter -idle 5"
        "deluge"
        "pcmanfm -d"
        "$HOME/.screenlayout/duh.sh"
        "mbsync -a"
)

for command_index in ${!start_commands[@]}; do
        run ${start_commands[$command_index]}
done

