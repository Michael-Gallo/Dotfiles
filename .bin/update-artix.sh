#!/bin/sh
# Updates the arch mirrors on artix
sudo reflector --country US --sort rate --latest 50 --save /etc/pacman.d/mirrorlist-arch
