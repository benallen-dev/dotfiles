local utils = require("utils")

--  ── Detect games and activate submap ─────────────────────────────────────

local games = { "cs2", "factorio" }

hl.on("window.active",
	--- @param win HL.Window
	function(win)
		local isGame = utils.tableContains(games, win.initial_class)
		local currentSubmap = hl.get_current_submap() or ""

		if (isGame == true) and (currentSubmap ~= "gaming") then
			hl.dispatch(hl.dsp.submap("gaming"))
		end

		if (isGame == false) and (currentSubmap == "gaming") then
			hl.dispatch(hl.dsp.submap("reset"))
		end
	end
)
