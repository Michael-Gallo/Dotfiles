#!/bin/sh
# a simple shell script to take pictures with scrot , takes current time as default image name and saves to ~/pictures/screenshots
# if there is an argument it'll take a picture of the entire desktop
# filename=$(echo -e $( date +"%h-%d-%y-%H:%M")|dmenu -i)
storage_directory="$HOME/pictures/screenshots"
scrot_command=$([ -z "$1" ] && echo -e "scrot -s" || echo -e "scrot -u")
([ -d $storage_directory ]\
	||mkdir -pv $storage_directory) \
	; $scrot_command "$(echo -e $( date +"%h-%d-%y-%H:%M")|dmenu -i).png" -e 'mv $f ~/pictures/screenshots'
