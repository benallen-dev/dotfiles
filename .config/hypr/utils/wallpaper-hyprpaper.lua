local M = {}

-- TODO: Move to constants
local MONITOR = "HDMI-A-1"
local WALLDIR = os.getenv("HOME") .. "/yoink/categorised/keep/"
local HYPRPAPER_CONFIG = os.getenv("HOME") .. "/.config/hypr/hyprpaper.conf"

-- HELPERS
local function splitPath(path)
	local dir, filename = path:match("^(.*/)(.+)$")
	if not filename then
		dir, filename = "", path
	end
	local basename, ext = filename:match("^(.+)%.([^%.]+)$")
	if not basename then
		basename = filename
	end

	return dir, basename, ext
end

local function exists(path)
	local f = io.open(path, "r")
	if f then
		f:close()
	end
	return f ~= nil
end

local function dim_image(input, output, amount, blur)
	amount = amount or 0.7

	if amount == 1.0 and ~blur then
		hl.notification.create({
			text = "skipping dim",
			timeout = 1000,
		})
		return
	end

	local cmd = string.format(
		"magick %q -resize 12.5%% -blur 0x1 -resize 800%% -evaluate multiply %.2f %q 2>&1",
		input,
		amount,
		output
	)
	return os.execute(cmd) == 0
end

-- WALLPAPER HELPERS START HERE

local function getWallFromIpc()
	local f = io.popen("hyprctl hyprpaper listactive")

	if f then
		for line in f:lines() do
			local start = line:find(MONITOR .. ": ", 1, true)
			if start then
				f:close()
				return line:sub(start + #MONITOR + 2)
			end
		end

		f:close()
	end
end

local function getDimmedWall(path)
	-- If path already contains ".dimmed." return path
	if path:find(".dimmed.", 1, true) then
		return path
	end

	local dir, basename, ext = splitPath(path)

	local dimmedPath = dir .. basename .. ".dimmed." .. ext
	local tmpPath = "/tmp/" .. basename .. ".dimmed." .. ext

	-- return dimmedPath
	if not exists(dimmedPath) then
		-- let's use /tmp while we test
		dim_image(path, tmpPath, 0.6)
	end

	return tmpPath
end

local function getOriginalWall(path)
	-- If path already contains ".dimmed." return path
	if not path:find(".dimmed.", 1, true) then
		return path
	end

	local _, basename, ext = splitPath(path:gsub("%.dimmed", ""))
	local ogPath = WALLDIR .. basename .. "." .. ext

	return ogPath
end

local function set_wallpaper(path)
	os.execute('hyprctl hyprpaper wallpaper "' .. MONITOR .. "," .. path .. '" &')
end

-- EXPORTED FUNCTIONS START HERE
--
-- Switches automatically between dimmed and original wallpapers depending
-- on how many windows exist in the workspace
local function updateDimmed(ws)
	local windows = hl.get_workspace_windows(ws)

	local currentWall = getWallFromIpc()

	if #windows == 0 and currentWall:find("%.dimmed%.") then
		local newWall = getOriginalWall(currentWall)
		set_wallpaper(newWall)
		return
	elseif #windows > 0 and not currentWall:find("%.dimmed%.") then
		local newWall = getDimmedWall(currentWall)
		set_wallpaper(newWall)
		return
	end
end

local function toggleDimmed()
	local currentWall = getWallFromIpc()

	if currentWall:find("%.dimmed%.") then
		local newWall = getOriginalWall(currentWall)
		set_wallpaper(newWall)
		return
	else
		local newWall = getDimmedWall(currentWall)
		set_wallpaper(newWall)
		return
	end
end

M.toggleDimmed = toggleDimmed
M.updateDimmed = updateDimmed

return M
