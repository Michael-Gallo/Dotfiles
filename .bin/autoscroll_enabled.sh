#!/bin/sh
	for id in `xinput --list|grep 'Logitech Gaming Mouse G600\|Razer'|perl -ne 'while (m/id=(\d+)/g){print "$1\n";}'`; do
		{
		xinput --set-prop $id 'Evdev Wheel Emulation' 1
		xinput --set-prop $id 'Evdev Wheel Emulation Button' "2"
		xinput --set-prop $id 'Evdev Wheel Emulation Axes' 6 7 4 5
		xinput --set-prop $id "libinput Scroll Method Enabled" 0 0 1
		xinput --set-prop $id "libinput Scroll Method Enabled Default" 0 0 1
		} 2>/dev/null
	done
