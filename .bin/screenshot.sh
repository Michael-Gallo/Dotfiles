#!/bin/sh

filename=$(echo -e $(date +"%T.png")|dmenu -i)
storage_directory="$HOME/pictures/screenshots"
([ -d $storage_directory ]||mkdir -pv $storage_directory) ; import "$storage_directory/$filename"
