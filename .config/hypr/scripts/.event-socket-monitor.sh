#!/usr/bin/env zsh

# This script automatically enables and disables the gaming
# submap for Hyprland, based on activewindow events.

GAME_CLASSES=("cs2" "factorio")
GAME_STATE=0
NOTIFICATION_ID=0

is_game() {
	local window_data="$1"
	local class
	
	for class in "${GAME_CLASSES[@]}"; do
		if [[ $window_data =~ ^\>$class, ]]; then
			return 0
		fi
	done
	
	return 1
}

handle_event() {
	local event="$1"
	local data="$2"

	# Show notifications for submap changes
	if [[ $event == "submap" ]]; then
		# Close old notification
		gdbus call \
			--session \
			--dest org.freedesktop.Notifications \
			--object-path /org/freedesktop/Notifications \
			--method org.freedesktop.Notifications.CloseNotification "$NOTIFICATION_ID" \
			2>&1 > /dev/null

		if [[ $data =~ ^\>gaming ]]; then
			NOTIFICATION_ID=$(notify-send \
				-p \
				-t 3000 \
				-i /home/benallen/.config/hypr/img/link-gamer-pink.png \
				"Gaming mode" "Restricted subset of keybinds available"
			)
		else # NB: if I add more submaps, they'll all match this else-statement
			NOTIFICATION_ID=$(notify-send \
				-p \
				-t 3000 \
				-i /home/benallen/.config/hypr/img/link.png \
				"Normal mode" "Keybinds restored"
			)
		fi
	fi

	# Effects when active window changes
	if [[ $event == "activewindow" ]]; then

		# Switch between submaps when switching to/from a game
		if is_game "$data" && [[ $GAME_STATE -eq 0 ]]; then
			GAME_STATE=1
			hyprctl dispatch submap gaming 2>&1 > /dev/null
		elif ! is_game "$data" && [[ $GAME_STATE -eq 1 ]]; then
			GAME_STATE=0
			hyprctl dispatch submap reset 2>&1 > /dev/null
		fi
	fi
}

# Read from the hyprland socket and pass data to handle_event
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" |
	while IFS=">>" read -r event data; do
		handle_event $event $data
	done
