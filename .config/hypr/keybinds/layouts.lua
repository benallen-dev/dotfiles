local tables = require("utils.table")
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
	local newSplit = currentSplit == 1.0 and 0.70 or 1.0

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

--  ── Changing gaps ────────────────────────────────────────────────────────
local layout = constants.defaultLayout

hl.bind(mainMod .. " + T", function()
	local layouts = constants.layouts

	local next = tables.next(layouts, layout)
	if next then
		layout = next
		hl.config({
			general = {
				gaps_in = layouts[layout].gaps_in,
				gaps_out = layouts[layout].gaps_out,
			}
		})

		notification.create({
			title = "Set gaps to " .. layout,
			description = "Layout gaps changed",
			timeout = 5000,
			notificationId = notification.ids.LAYOUT
		})
	end
end)
