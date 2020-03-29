#!/bin/sh
# a simple shell script to take pictures with imagemagick , takes current time as default image name and saves to ~/pictures/screenshots
# if there is an argument it'll take a picture of the entire desktop
# filename=$(echo -e $( date +"%h-%d-%y-%H:%M")|dmenu -i)
storage_directory="$HOME/pictures/screenshots"
imgmgck_cmd=$([ -z "$1" ] && echo -e "import" || echo -e "import -window root")
([ -d $storage_directory ]\
	||mkdir -pv $storage_directory) \
	; $imgmgck_cmd "$storage_directory/$(echo -e $( date +"%h-%d-%y-%H:%M")|dmenu -i).png"
