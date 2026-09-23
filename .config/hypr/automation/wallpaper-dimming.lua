local wallpaper = require("utils.wallpaper")


hl.on("workspace.active", function(ws)
	wallpaper.updateDimmed(ws)
end)

hl.on("window.open", function()
	local ws = hl.get_active_workspace()
	wallpaper.updateDimmed(ws)
end)

hl.on("window.destroy", function()
	local ws = hl.get_active_workspace()
	wallpaper.updateDimmed(ws)
end)
