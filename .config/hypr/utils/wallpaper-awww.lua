local notification = require("utils.notification")

local M = {}

-- seed RNG
math.randomseed(os.time())

-- TODO: Move to constants
local MONITOR = "HDMI-A-1"
local WALLDIR = os.getenv("HOME") .. "/yoink/categorised/keep/"

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

local function getWallFromQuery()
	local f = io.popen("awww query")

	if f then
		for line in f:lines() do
			local type, config = line:match(".*currently displaying: (.*): (.*)")

			if type == "image" then
				return config
			end

			return nil
		end

		f:close()
	end
end

local function getDimmedWall(path)
	-- If path already contains ".dimmed." return path
	if path:find(".dimmed.", 1, true) then
		return path
	end

	local _, basename, ext = splitPath(path)

	-- local dimmedPath = dir .. basename .. ".dimmed." .. ext
	local tmpPath = "/tmp/" .. basename .. ".dimmed." .. ext

	-- return dimmedPath
	if not exists(tmpPath) then
		-- let's use /tmp while we test
		notification.create({
			title = "Dimming wallpaper",
			description = tmpPath
		})
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

---Returns path to a random wallpaper
---@return string? path path to a random wallpaper
local function getRandomWall()
	local p = io.popen("ls -A " .. WALLDIR)

	if p == nil then
		return
	end

	local files = {}
	for file in p:lines() do
		table.insert(files, file)
	end
	p:close()

	return WALLDIR .. files[math.random(#files)]
end

---Set wallpaper with awww img.
---@param path string Path to image
---@param transition? "none"|"simple"|"fade"|"left"|"right"|"top"|"bottom"|"wipe"|"wave"|"grow"|"center"|"any"|"outer"|"random" Transition type. Default "fade"
---@param duration? number
local function set_wallpaper(path, transition, duration)
	transition = transition or "fade"
	duration = duration or 1.0

	if transition == "wipe" then
		local angle = math.random(0, 359)
		transition = transition .. " --transition-angle " .. angle
	end



	local cmd = {
		"awww img",
		"--transition-type " .. transition,
		"--transition-duration " .. tostring(duration),
		path,
		"&",
	}

	os.execute(table.concat(cmd, " "))
end

-- EXPORTED FUNCTIONS START HERE
--
-- Switches automatically between dimmed and original wallpapers depending
-- on how many windows exist in the workspace
local function updateDimmed(ws)
	local windows = hl.get_workspace_windows(ws)

	local currentWall = getWallFromQuery()

	if currentWall == nil then
		-- hl.notification.create({
		-- 	text = "could not get current wall",
		-- 	timeout = 4000,
		-- })
		return
	end

	if #windows == 0 and currentWall:find("%.dimmed%.") then
		local newWall = getOriginalWall(currentWall)
		set_wallpaper(newWall, "fade", 0.5)
		return
	elseif #windows > 0 and not currentWall:find("%.dimmed%.") then
		local newWall = getDimmedWall(currentWall)
		set_wallpaper(newWall, "fade", 0.5)
		return
	end
end

local function toggleDimmed()
	local currentWall = getWallFromQuery()

	if currentWall == nil then
		-- hl.notification.create({
		-- 	text = "could not get current wall",
		-- 	timeout = 4000,
		-- })
		return
	end

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

local function randomWallpaper()
	local newWall = getRandomWall()
	if newWall then
		set_wallpaper(newWall, "wipe", 2.0)
	else
		hl.notification.create({
			text = "Could not get random wallpaper",
			timeout = 2000,
		})
	end
end

M.toggleDimmed = toggleDimmed
M.updateDimmed = updateDimmed
M.randomWallpaper = randomWallpaper

return M
