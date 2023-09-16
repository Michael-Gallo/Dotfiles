#!/bin/sh

# A dmenu binary prompt script
# Gives a dmenu prompt labeled with $1 to perform command $2.
# For example:
# `./prompt "Do you want to shutdown?" "shutdown -h now"`

[ "$(printf "No\\nYes" | $MENU -i -p "$1" )" = "Yes" ] && $2
