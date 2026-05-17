local utils = require("utils")

--  ── Submap changes ───────────────────────────────────────────────────────

local submapNotification = {
	gaming = {
		title = "Gaming mode",
		description = "Limited subset of keybinds available",
		icon = "/home/benallen/.config/hypr/assets/link-gamer-pink.png",
		notificationId = utils.notificationIds.SUBMAP
	},
	default = {
		title = "Normal mode",
		description = "Keybinds restored",
		icon = "/home/benallen/.config/hypr/assets/link.png",
		notificationId = utils.notificationIds.SUBMAP
	},
}

hl.on("keybinds.submap",
	--- @param newSubmapName string
	function(newSubmapName)
		local subMap = newSubmapName ~= "" and newSubmapName or "default"
		-- This will break if the submap is unknown
		utils.notify(submapNotification[subMap])
	end
)
