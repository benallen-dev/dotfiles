local M = {}

M.ids = {
	DEFAULT = "hyprland-notification",
	SUBMAP  = "hyprland-notification-submap",
	LAYOUT  = "hyprland-notification-layout",
}
---------------------------
---- Utility Functions ----
---------------------------

--- Create a notification
--- @class NotifyOpts
--- @field timeout? number
--- @field title? string
--- @field description? string
--- @field icon? string
--- @field notificationId? string
--- @field urgency? '"critical"'|'"normal"'|'"low"'

--- @param opts NotifyOpts|nil
function M.create(opts)
	opts = opts or {}
	local timeout = opts.timeout or 3000
	local title = opts.title or "Notification"
	local description = opts.description or ""
	local icon = opts.icon or "system-run"
	local urgency = opts.urgency or "normal"
	local notificationId = opts.notificationId or M.ids.DEFAULT

	if notificationId ~= M.ids.DEFAULT then
		M.close(notificationId)
	end

	local cmd = string.format([[notify-send \
		--expire-time=%d \
		--urgency=%s \
		--icon=%s \
		--print-id \
		'%s' '%s' \
		> /tmp/%s
		]],
		timeout,
		urgency,
		icon,
		title,
		description,
		notificationId
	)

	hl.exec_cmd(cmd)
end

--- Close a notification
--- @param id string
function M.close(id)
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

return M
