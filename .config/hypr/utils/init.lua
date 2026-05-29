local M = {}

M.notificationIds = {
	DEFAULT = "hyprland-notification",
	SUBMAP = "hyprland-notification-submap",
	LAYOUT = "hyprland-notification-layout",
}
---------------------------
---- Utility Functions ----
---------------------------

--- Create a notification
--- @param opts table { timeout: number, title: string, description: string, icon: string, notificationId: string }
function M.notify(opts)
	opts = opts or {}
	local timeout = opts.timeout or 3000
	local title = opts.title or "Notification"
	local description = opts.description or ""
	local icon = opts.icon or "system-run"
	local notificationId = opts.notificationId or M.notificationIds.DEFAULT

	if notificationId ~= M.notificationIds.DEFAULT then
		M.closeNotification(notificationId)
	end

	local cmd = string.format([[notify-send \
		--expire-time=%d \
		--icon=%s \
		--print-id \
		'%s' '%s' \
		> /tmp/%s
		]],
		timeout,
		icon,
		title,
		description,
		notificationId
	)

	hl.exec_cmd(cmd)
end

--- Close a notification
--- @param id string
function M.closeNotification(id)
	local cmd = string.format([[
	NOTIFICATION_ID=$(cat /tmp/%s);
	gdbus call \
		--session \
		--dest org.freedesktop.Notifications \
		--object-path /org/freedesktop/Notifications \
		--method org.freedesktop.Notifications.CloseNotification "$NOTIFICATION_ID" \
		2>&1 > /dev/null
	]], id)

	hl.exec_cmd(cmd)
end

--- Check if a table contains a string

function M.tableContains(table, query)
	for _, v in ipairs(table) do
		if v == query then return true end
	end
	return false
end

return M
