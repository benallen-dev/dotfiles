-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
hl.on("hyprland.start", function()
	hl.exec_cmd("alacritty")

	-- Allows GUI apps to ask for elevated privileges
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Core UI stuff
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("sleep 2 && /home/benallen/bin/rotate-wallpaper configonly") -- sets a new wallpaper for next time

	-- # Daemons
	-- Daemons
	hl.exec_cmd("playerctld daemon")
	-- #hl.exec_cmd("pipewire")
	-- #hl.exec_cmd("wireplumber")

	-- # WM Event handlers TODO: UPDATE TO USE hl.on("window.active", function(window, active))
--	hl.exec_cmd("/home/benallen/.config/hypr/scripts/event-socket-monitor.sh")

	-- # Screen capture fix
	hl.exec_cmd("/home/benallen/.config/hypr/scripts/xdph-nuke.sh")

	-- # Env config
	hl.exec_cmd("/home/benallen/.config/hypr/scripts/tmux-env.sh tmux")

	-- # Autostart apps
	hl.exec_cmd("/home/benallen/bin/streamcontroller -b")
	hl.exec_cmd("udiskie --tray")
	hl.exec_cmd("steam -silent")
end)
