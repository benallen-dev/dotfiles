#!/usr/bin/env zsh

WORKINGDIR="$HOME/.config/rofi/"
MAP="$WORKINGDIR/layouts.csv"

# TODO: Move this to lua in .config/hypr/keybinds/layouts.lua
cat "$MAP" \
    | cut -d ',' -f 1 \
    | rofi -dmenu -p "Choose layout" \
    | xargs -i --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
	| xargs -i --no-run-if-empty /bin/bash -c "hyprctl eval 'setGaps(\"{}\")'"

exit 0

