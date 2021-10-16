#!/bin/sh
# Updates the arch mirrors on artix
# cp into /etc/cron.weekly to have run automatically
sudo reflector --country US --sort rate --latest 50 --save /etc/pacman.d/mirrorlist-arch
