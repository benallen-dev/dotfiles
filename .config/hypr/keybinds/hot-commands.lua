local constants = require("keybinds.constants")
local notification = require("utils.notification")
local picker = require("utils.picker")

local mainMod = constants.mainMod
local wallpaper = require("utils.wallpaper-awww")

_G.archiveWallpaper = wallpaper.archiveCurrent

--  ── Hot commands ─────────────────────────────────────────────────────────
local hotCmds = {
	{ label = "🖼️ Archive Wallpaper", cmd = [[hyprctl eval 'archiveWallpaper()']] },
	{ label = "🎛️ Streamcontroller", cmd = [[hyprctl eval 'hl.exec_cmd("/home/benallen/bin/streamcontroller")']] },
	{ label = "🖥️ Shutdown", cmd = [[shutdown now]] },
	{ label = "🖥️ Reboot", cmd = [[reboot]] },
}

hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(picker.buildCmd("Hot commands", hotCmds)))
