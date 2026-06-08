local constants = require("keybinds.constants")

--  ── My programs ──────────────────────────────────────────────────────────
local terminal = constants.terminal
local fileManager = constants.fileManager
local menu = constants.menu
local emojipicker = constants.emojipicker
local browser = constants.browser


--  ── Keybinds ─────────────────────────────────────────────────────────────
local mainMod = constants.mainMod

--  ── Always-active binds ──────────────────────────────────────────────────
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal),                       { submap_universal = true })
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser),                        { submap_universal = true })
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(fileManager),                    { submap_universal = true })
hl.bind(mainMod .. " + Q",         hl.dsp.window.close(),                           { submap_universal = true })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill(),                            { submap_universal = true })
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ action = "toggle" }), { submap_universal = true })
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }),      { submap_universal = true })
hl.bind(mainMod .. " + M",         hl.dsp.exit(),                                   { submap_universal = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +10%"),     { submap_universal = true, locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -10%"),     { submap_universal = true, locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),     { submap_universal = true, locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { submap_universal = true, locked = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { submap_universal = true, locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { submap_universal = true, locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true, locked = true })

--  ── Base keymap ──────────────────────────────────────────────────────────
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(emojipicker))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("$HOME/bin/rotate-wallpaper")) -- TODO: migrate script to lua config?
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot --mode region --clipboard-only"))

-- Workspaces
for i = 1, 10 do
	local key = i % 10
	-- F-key variant
	hl.bind("F" .. key+1,         hl.dsp.focus({ workspace = i }),       { submap_universal = true })
	hl.bind("SHIFT + F" .. key+1,         hl.dsp.window.move({ workspace = i }),       { submap_universal = true })

	-- mainMod variant
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

