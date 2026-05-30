local constants = require("keybinds.constants")

local mainMod = constants.mainMod

--  ── Toggle gaming submap ─────────────────────────────────────────────────
hl.bind(mainMod .. " + G", function()
	local currentMap = hl.get_current_submap()
	local nextMap = currentMap == "gaming" and "reset" or "gaming"

	hl.dispatch(hl.dsp.submap(nextMap))
end, { submap_universal = true })


--  ── Gaming submap definition──────────────────────────────────────────────
hl.define_submap("gaming", function ()
	hl.bind("CTRL + SPACE",    hl.dsp.no_op())  -- Rofi / Menu
	hl.bind(mainMod .. " + W", hl.dsp.no_op())  -- Wallpaper rotation
	hl.bind("SHIFT + TAB",     hl.dsp.no_op())  -- Move window
	hl.bind("CTRL + TAB",      hl.dsp.no_op())  -- Resize window
end)
