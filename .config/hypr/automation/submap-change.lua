local notification = require("utils.notification")

--  ── Submap changes ───────────────────────────────────────────────────────
local submapNotification = {
	gaming = {
		title = "Gaming mode",
		description = "Limited subset of keybinds available",
		icon = "/home/benallen/.config/hypr/assets/link-gamer-pink.png",
		notificationId = notification.ids.SUBMAP
	},
	default = {
		title = "Normal mode",
		description = "Keybinds restored",
		icon = "/home/benallen/.config/hypr/assets/link.png",
		notificationId = notification.ids.SUBMAP
	},
}

hl.on("keybinds.submap",
	--- @param newSubmapName string
	function(newSubmapName)
		local subMap = newSubmapName ~= "" and newSubmapName or "default"
		-- This will break if the submap is unknown
		notification.create(submapNotification[subMap])
	end
)
