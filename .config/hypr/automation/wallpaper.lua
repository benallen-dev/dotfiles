local wallpaper = require("utils.wallpaper-awww")
local notification = require("utils.notification")
-- local wallpaper = require("utils.wallpaper")

hl.on("workspace.active", function(ws)
	notification.create({
		title = "workspace",
		description = "workspace.active: " .. ws.name,
	})
	-- hl.notification.create({
	-- 	text = "workspace.active: " .. ws.name,
	-- 	timeout = 2000,
	-- 	icon = 5,
	-- })

	wallpaper.updateDimmed(ws)
end)

hl.on("window.open_early", function(win)
	notification.create({
		title = "window.open",
		description = win.initial_title .. " (" .. win.initial_class .. ")",
	})
	-- hl.notification.create({
	-- 	text = "window.open: " .. win.initial_title .. " (" .. win.initial_class .. ")",
	--
	-- 	timeout = 2000,
	-- })
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
	notification.create({
		title = "window.destroy",
		description = win.title or win.initial_title or "<nil>"
	})
	-- hl.notification.create({
	-- 	text = "window.destroy: " .. (win.title or win.initial_title or "<nil>"),
	-- 	timeout = 2000,
	-- 	icon = 3,
	-- })

	local ws = hl.get_active_workspace()

	wallpaper.updateDimmed(ws)
end)

-- Uncomment when hyprland 0.57 is released
-- hl.on("window.minimize", function()
-- 	local ws = hl.get_active_workspace()
-- 	wallpaper.updateDimmed(ws)
-- end)
