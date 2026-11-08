local wallpaper = require("utils.wallpaper-awww")

hl.on("workspace.active", function(ws)
	wallpaper.updateDimmed(ws)
end)

hl.on("window.open_early", function(win)
	wallpaper.updateDimmed(win.workspace)
end)

hl.on("window.destroy", function()
	local ws = hl.get_active_workspace()

	wallpaper.updateDimmed(ws)
end)

-- Uncomment when hyprland 0.57 is released
-- hl.on("window.minimize", function()
-- 	local ws = hl.get_active_workspace()
-- 	wallpaper.updateDimmed(ws)
-- end)
