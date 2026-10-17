local tables = require("utils.table")
local constants = require("keybinds.constants")
local notification = require("utils.notification")
local picker = require("utils.picker")

local mainMod = constants.mainMod

--  ── Toggle layouts ───────────────────────────────────────────────────────
hl.bind(mainMod .. " + Y", function()
	local currentLayout = hl.get_config("general.layout")
	local newLayout = currentLayout == "scrolling" and "dwindle" or "scrolling"

	notification.create({
		timeout = 5000,
		title = "Switched to " .. newLayout:upper(),
		description = "Layout changed",
	})

	hl.config({ general = { layout = newLayout } })
end)

--  ── Toggle split ratios ──────────────────────────────────────────────────
hl.bind(mainMod .. " + R", function()
	local currentSplit = hl.get_config("dwindle.default_split_ratio")
	local newSplit = currentSplit == 1.0 and 0.70 or 1.0

	local icon = newSplit == 1.0 and "/home/benallen/.config/hypr/assets/tiles-equal.png"
		or "/home/benallen/.config/hypr/assets/tiles-thirds.png"

	notification.create({
		title = "Switched split ratio to " .. tostring(newSplit),
		description = "Split ratio changed",
		timeout = 5000,
		icon = icon,
		notificationId = notification.ids.LAYOUT,
	})

	hl.config({ dwindle = { default_split_ratio = newSplit } })
	hl.dispatch(hl.dsp.layout("movetoroot"))
	hl.dispatch(hl.dsp.layout("splitratio " .. tostring(newSplit) .. " exact"))
end)

--  ── Changing gaps ────────────────────────────────────────────────────────
local layout = constants.defaultLayout

-- Global function for calling from hyprctl
_G.setGaps = function(layoutName)
	local layouts = constants.layouts

	if type(layoutName) ~= "string" then
		notification.create({
			icon = "dialog-warning",
			title = "Error",
			description = "layout must be a string",
			timeout = 5000,
			notificationId = notification.ids.LAYOUT,
		})
	end

	if layouts[layoutName] == nil then
		notification.create({
			icon = "dialog-warning",
			title = "Could not switch to" .. layoutName,
			description = "specified layout does not exist",
			timeout = 5000,
			notificationId = notification.ids.LAYOUT,
		})
		return
	end

	hl.config({
		general = {
			gaps_in = layouts[layoutName].gaps_in,
			gaps_out = layouts[layoutName].gaps_out,
		},
	})

	notification.create({
		title = "Set gaps to " .. layoutName,
		description = "Layout gaps changed",
		timeout = 5000,
		notificationId = notification.ids.LAYOUT,
	})
end

hl.bind(mainMod .. " + SHIFT + T", function()
	local layouts = constants.layouts

	local next = tables.next(layouts, layout)
	if next then
		layout = next
		hl.config({
			general = {
				gaps_in = layouts[layout].gaps_in,
				gaps_out = layouts[layout].gaps_out,
			},
		})

		notification.create({
			title = "Set gaps to " .. layout,
			description = "Layout gaps changed",
			timeout = 5000,
			notificationId = notification.ids.LAYOUT,
		})
	end
end)

--  ── Rofi layout picker ───────────────────────────────────────────────────
--  label = shown in rofi, cmd = raw shell snippet run on selection.
--  Built once at load; spawned async — never block bind callbacks with
--  io.popen/os.execute (freezes the compositor).
local layoutChoices = {
	{ label = "🫠 Normal", cmd = [[hyprctl eval 'setGaps("normal")']] },
	{ label = "🌲 Spacious", cmd = [[hyprctl eval 'setGaps("spacious")']] },
	{ label = "🍔 Chunky", cmd = [[hyprctl eval 'setGaps("chunky")']] },
	{ label = "🎞️ Cinema", cmd = [[hyprctl eval 'setGaps("cinema")']] },
	{ label = "📽️ Cinema (tight)", cmd = [[hyprctl eval 'setGaps("cinema_tight")']] },
	{ label = "🌐 Youtube", cmd = [[hyprctl eval 'setGaps("youtube")']] },
	{ label = "🪼 Jellyfin", cmd = [[hyprctl eval 'setGaps("jellyfin")']] },
}

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(picker.buildCmd("Choose layout", layoutChoices)))
