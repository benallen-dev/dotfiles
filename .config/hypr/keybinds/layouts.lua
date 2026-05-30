local constants = require("keybinds.constants")
local notification = require("utils.notification")

local mainMod = constants.mainMod

--  ── Toggle layouts ───────────────────────────────────────────────────────
hl.bind(mainMod .. " + Y", function()
	local currentLayout = hl.get_config("general.layout")
	local newLayout = currentLayout == "scrolling" and "dwindle" or "scrolling"

	notification.create({
		timeout = 5000,
		title = "Switched to " .. newLayout:upper(),
		description = "Layout changed"
	})

	hl.config({ general = { layout = newLayout } })
end)

--  ── Toggle split ratios ──────────────────────────────────────────────────
hl.bind(mainMod .. " + R", function()
	local currentSplit = hl.get_config("dwindle.default_split_ratio")
	local newSplit = currentSplit == 1.0 and 0.75 or 1.0

	local icon = newSplit == 1.0
		and "/home/benallen/.config/hypr/assets/tiles-equal.png"
		or "/home/benallen/.config/hypr/assets/tiles-thirds.png"

	notification.create({
		title = "Switched split ratio to " .. tostring(newSplit),
		description = "Split ratio changed",
		timeout = 5000,
		icon = icon,
		notificationId = notification.ids.LAYOUT
	})

	hl.config({ dwindle = { default_split_ratio = newSplit } });
	hl.dispatch(hl.dsp.layout("movetoroot"))
	hl.dispatch(hl.dsp.layout("splitratio " .. tostring(newSplit) .. " exact"))
end)

