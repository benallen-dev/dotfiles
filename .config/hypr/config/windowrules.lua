--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

--  ── Example window rules that are useful ─────────────────────────────────

local suppressMaximuzeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name           = "suppress-maximize-events",
	match          = { class = ".*" },

	suppress_event = "maximize",
})

suppressMaximuzeRule:set_enabled(true)

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})


--  ── Custom Rules ─────────────────────────────────────────────────────────

hl.window_rule({
	name = "float-kcalc",
	match = {
		class = "org.kde.kcalc"
	},
	pseudo = true,
})

hl.window_rule({
	name = "float Thunar file operations",
	match = {
		initial_title = "File Operation Progress",
		initial_class = "thunar",
	},
	float = true,
	animation = "slide left",
	size = { 950, 100 },
	move = { "20", "60" },
	--move = { "((monitor_w*1)-window_w-20)", "60" },
})

hl.window_rule({
	name = "zen-pip",
	match = {
		title = "Picture-in-Picture",
	},
	float = true,
	pin = true,
	content = "video",
	animation = "popin",
	keep_aspect_ratio = true,
	size = { 1280, 720 },
	move = { "((monitor_w*1)-window_w-50)", "((monitor_h*1)-window_h-50)" },
})

hl.window_rule({
	name = "zen-notification",
	match = {
		class = "zen",
		initial_title = "",
	},
	float = true,
	no_initial_focus = true,
	pin = true,
	move = { "((monitor_w*1)-window_w-20)", "((monitor_h*1)-window_h-20)" },
})
