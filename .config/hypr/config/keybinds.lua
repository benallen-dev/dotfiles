local utils       = require("utils")

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "rofi -show drun"
local emojipicker = "rofimoji --max-recent 0"
local browser     = "zen"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod     = "SUPER"

--  ── Toggle layouts ───────────────────────────────────────────────────────
hl.bind(mainMod .. " + Y", function()
	local currentLayout = hl.get_config("general.layout")
	local newLayout = currentLayout == "scrolling" and "dwindle" or "scrolling"

	utils.notify({
		timeout = 5000,
		title = "Switched to " .. newLayout:upper(),
		description = "Layout changed"
	})

	hl.config({ general = { layout = newLayout } })
end)

hl.bind(mainMod .. " + R", function()
	local currentSplit = hl.get_config("dwindle.default_split_ratio")
	local newSplit = currentSplit == 1.0 and 0.75 or 1.0

	local icon = newSplit == 1.0 
		and "/home/benallen/.config/hypr/assets/tiles-equal-color.png"
		or "/home/benallen/.config/hypr/assets/tiles-thirds-color.png"

	utils.notify({
		title = "Switched split ratio to " .. tostring(newSplit),
		description = "Split ratio changed",
		timeout = 5000,
		icon = icon,
		notificationId = utils.notificationIds.LAYOUT
	})

	hl.config({ dwindle = { default_split_ratio = newSplit } });
	hl.dispatch(hl.dsp.layout("movetoroot"))
	hl.dispatch(hl.dsp.layout("splitratio " .. tostring(newSplit) .. " exact"))
end)


--  ── Toggle gaming submap ─────────────────────────────────────────────────
hl.bind(mainMod .. " + G", function()
	local currentMap = hl.get_current_submap()
	local nextMap = currentMap == "gaming" and "reset" or "gaming"

	hl.dispatch(hl.dsp.submap(nextMap))
end, { submap_universal = true })

--  ── Always-active binds ──────────────────────────────────────────────────
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal),                       { submap_universal = true })
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser),                        { submap_universal = true })
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(fileManager),                    { submap_universal = true })
hl.bind(mainMod .. " + Q",         hl.dsp.window.close(),                           { submap_universal = true })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill(),                            { submap_universal = true })
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ action = "toggle" }), { submap_universal = true })
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }),      { submap_universal = true })


hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +10%"),     { submap_universal = true, locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -10%"),     { submap_universal = true, locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),     { submap_universal = true, locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { submap_universal = true, locked = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { submap_universal = true, locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { submap_universal = true, locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true, locked = true })

--  ── Base keymap ──────────────────────────────────────────────────────────
-- Hotkeys
hl.bind(mainMod .. " + M", hl.dsp.exit(), { submap_universal = true })
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(emojipicker))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("$HOME/bin/rotate-wallpaper")) -- TODO: migrate script to lua config?
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot --mode region --clipboard-only"))

-- Workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }),       { submap_universal = true })
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { submap_universal = true })
end

-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Drag / Resize windows
hl.bind("SHIFT + TAB", hl.dsp.window.drag(), { mouse = true })
hl.bind("CTRL + TAB", hl.dsp.window.resize(), { mouse = true })

--  ── Gaming submap ────────────────────────────────────────────────────────


hl.define_submap("gaming", function ()
	hl.bind("CTRL + SPACE",    hl.dsp.no_op())  -- Rofi / Menu
	hl.bind(mainMod .. " + W", hl.dsp.no_op())  -- Wallpaper rotation
	hl.bind("SHIFT + TAB",     hl.dsp.no_op())  -- Move window
	hl.bind("CTRL + TAB",      hl.dsp.no_op())  -- Resize window
end)
