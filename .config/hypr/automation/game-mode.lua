local tables = require("utils.table")

local games = { "cs2", "factorio" }

--  ── Detect games and activate submap ─────────────────────────────────────
hl.on("window.active",
	--- @param win HL.Window
	function(win)
		if win == nil then
			return
		end

		local currentSubmap = hl.get_current_submap() or ""
		local isGame = tables.contains(games, win.initial_class)

		if (isGame == true) and (currentSubmap ~= "gaming") then
			hl.dispatch(hl.dsp.submap("gaming"))
		end

		if (isGame == false) and (currentSubmap == "gaming") then
			hl.dispatch(hl.dsp.submap("reset"))
		end
	end
)
