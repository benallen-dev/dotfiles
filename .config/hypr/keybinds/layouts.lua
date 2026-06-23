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
local gaps = "normal"

hl.bind(mainMod .. " + T", function()
	local cycle = {
		normal = {
			gaps_in = 5,
			gaps_out = 20,
		},
		spacious = {
			gaps_in = 50,
			gaps_out = 100,
		},
		chunky = {
			gaps_in  = {
				top = 100,
				right = 150,
				bottom = 100,
				left = 150,
			},
			gaps_out = {
				top = 150,
				right = 200,
				bottom = 150,
				left = 200,
			}
		}
	}

	local next = tables.next(cycle, gaps)
	if next then
		gaps = next
		hl.config({
			general = {
				gaps_in = cycle[gaps].gaps_in,
				gaps_out = cycle[gaps].gaps_out,
			}
		})

		notification.create({
			title = "Set gaps to " .. gaps,
			description = "Layout gaps changed",
			timeout = 5000,
			notificationId = notification.ids.LAYOUT
		})
	end
end)
