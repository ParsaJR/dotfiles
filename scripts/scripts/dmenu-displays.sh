#!/bin/bash

choices="Internal Only\nMirror to external\n"

answer=$(echo -e $choices | dmenu -i -p "Mirror to what?:")

case $answer in
"Internal Only")
	xrandr --output HDMI-2 --off
	;;
"Mirror to external")
	xrandr --output HDMI-2 --auto --same-as DP-1
	;;
esac
