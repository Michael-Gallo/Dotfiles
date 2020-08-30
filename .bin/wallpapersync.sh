#!/bin/bash

wallpaper=$(grep file $HOME/.config/nitrogen/bg-saved.cfg | head -n 1 | awk -F '=' '{print $2}')
sudo sed -i 's|background =.*$|background = '"${wallpaper}"'|g' /etc/lightdm/lightdm-gtk-greeter.conf

