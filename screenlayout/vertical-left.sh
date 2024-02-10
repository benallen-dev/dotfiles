#!/bin/sh
xrandr \
	--output DP-4 --primary --mode 3440x1440 --pos 1080x0 --rotate normal \
	--output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate left \
	--output DVI-D-0 --off \
	--output DP-1 --off \
	--output DP-2 --off \
	--output DP-3 --off \
	--output DP-0 --off \
	--output DP-5 --off
