local M = {}

--  ── Programs ─────────────────────────────────────────────────────────────
M.terminal = "alacritty"
M.fileManager = "thunar"
M.menu = "rofi -show drun"
M.emojipicker = "rofimoji --max-recent 0"
M.browser = "zen"

--  ── Keybinds ─────────────────────────────────────────────────────────────
M.mainMod = "SUPER"

-- M.defaultLayout = "cinema_tight"
M.defaultLayout = "jellyfin"
M.layouts = {
	normal = {
		gaps_in = 5,
		gaps_out = 20,
	},
	spacious = {
		gaps_in = 50,
		gaps_out = 100,
	},
	chunky = {
		gaps_in = {
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
		},
	},
	cinema = { -- keeps windows on lower part of the screen to avoid neck strain
		gaps_in = 40,
		gaps_out = {
			top = 550,
			right = 100,
			bottom = 200,
			left = 100,
		},
	},
	cinema_tight = {
		gaps_in = 10,
		gaps_out = {
			top = 600,
			right = 100,
			bottom = 200,
			left = 100,
		},
	},
	youtube = {
		gaps_in = 10,
		gaps_out = {
			top = 600,
			right = 905,
			bottom = 200,
			left = 905,
		},
	},
	jellyfin = {
		gaps_in = 10,
		gaps_out = {
			top = 600,
			right = 755,
			bottom = 200,
			left = 755,
		},
	},
}

return M
