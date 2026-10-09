local wallpaper = require("utils.wallpaper-awww")
-- local wallpaper = require("utils.wallpaper")

hl.on("workspace.active", function(ws)
	hl.notification.create({
		text = "workspace.active: " .. ws.name,
		timeout = 2000,
		icon = 5
	})

	wallpaper.updateDimmed(ws)
end)

hl.on("window.open_early", function(win)
	hl.notification.create({
		text = "window.open: " .. win.initial_title .. " (" .. win.initial_class .. ")",

		timeout = 2000,
	})
	-- local ws = hl.get_active_workspace()
	wallpaper.updateDimmed(win.workspace)
end)

-- hl.on("window.close", function(win)
-- 	hl.notification.create({
-- 		text = "window.close: " .. (win.title or win.initial_title or "<nil>"),
-- 		timeout = 2000,
-- 	})
-- end)

hl.on("window.destroy", function(win)
	-- local oldWin = hl.get_last_window() or {}
	hl.notification.create({
		text = "window.destroy: " .. (win.title or win.initial_title or "<nil>"),
		timeout = 2000,
		icon = 3,
	})

	local ws = hl.get_active_workspace()

	wallpaper.updateDimmed(ws)
end)

-- Uncomment when hyprland 0.57 is released
-- hl.on("window.minimize", function()
-- 	local ws = hl.get_active_workspace()
-- 	wallpaper.updateDimmed(ws)
-- end)
