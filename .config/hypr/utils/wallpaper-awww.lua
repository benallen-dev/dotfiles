local notification = require("utils.notification")

local M = {}

-- seed RNG
math.randomseed(os.time())

-- TODO: Move to constants
local WALLDIR = os.getenv("HOME") .. "/yoink/categorised/keep/"
local WALLDIR_DIMMED = os.getenv("HOME") .. "/yoink/categorised/dimmed/"

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

---@overload fun(path: string): string
---@overload fun(path: string, skipGeneration: boolean): string|nil
---@return string|nil
local function getDimmedWall(path, skipGeneration)
	-- TODO Refactor boolean trap
	skipGeneration = skipGeneration or false
	-- If path already contains ".dimmed." return path
	-- TODO Maybe just check if it's in WALLDIR_DIMMED
	if path:find(".dimmed.", 1, true) then
		return path
	end

	local _, basename, ext = splitPath(path)
	local dimmedPath = WALLDIR_DIMMED .. basename .. ".dimmed." .. ext

	if not exists(dimmedPath) then
		if skipGeneration then
			return nil
		end

		notification.create({
			title = "Dimming wallpaper",
			description = dimmedPath,
		})
		dim_image(path, dimmedPath, 0.6)
	end

	return dimmedPath
end

local function getOriginalWall(path)
	-- If path doesn't contain ".dimmed." return path
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

--  ── EXPORTED FUNCTIONS START HERE ────────────────────────────────────────

-- Switches automatically between dimmed and original wallpapers depending
-- on how many windows exist in the workspace
local function updateDimmed(ws)
	local windows = hl.get_workspace_windows(ws)

	local currentWall = getWallFromQuery()

	if currentWall == nil then
		return
	end

	if #windows == 0 and currentWall:find("%.dimmed%.") then
		local newWall = getOriginalWall(currentWall)
		set_wallpaper(newWall, "fade", 0.5)
		return
	elseif #windows > 0 and not currentWall:find("%.dimmed%.") then
		local newWall = getDimmedWall(currentWall) -- will return string because param 2 is unset
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
		--
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
	local ws = hl.get_active_workspace()
	if ws == nil then
		notification.create({
			title = "Could not get active workspace",
			icon = "dialog-error",
		})
		return
	end
	local windows = hl.get_workspace_windows(ws)

	local newWall = getRandomWall()
	if newWall == nil then
		notification.create({
			title = "Could not get new Wallpaper",
			icon = "dialog-error",
		})
		return
	end

	if #windows > 0 then
		newWall = getDimmedWall(newWall)
	end

	if newWall then
		set_wallpaper(newWall, "random", 1.0)
	else
		notification.create({
			title = "Could not get random wallpaper",
			icon = "dialog-warning",
			timeout = 2000,
		})
	end
end

-- Finds the currently active wallpaper and its dimmed counterpart, then moves both to the archive folder
local function archiveCurrent()
	local wallpaper = getWallFromQuery()
	local dimmedWallpaper

	if wallpaper == nil then
		notification.create({
			title = "Wallpaper not found",
			description = wallpaper,
			icon = "dialog-warning",
			timeout = 5000,
		})
		return nil
	end

	if wallpaper:find("%.dimmed%.") then
		dimmedWallpaper = wallpaper
		wallpaper = getOriginalWall(wallpaper)
	else
		dimmedWallpaper = getDimmedWall(wallpaper, true) -- TODO: Refactor boolean trap
	end

	if wallpaper ~= nil then
		randomWallpaper()

		-- Move undimmed image
		local newPath = wallpaper:gsub("keep", "archive")
		local moveOk, moveError = os.rename(wallpaper, newPath)
		if not moveOk then
			notification.create({
				title = "Could not archive wallpaper",
				description = moveError,
				icon = "dialog-error",
				timeout = 5000,
			})
		end

		-- Delete dimmed image if it exists
		if dimmedWallpaper then
			local delOk, delError = os.remove(dimmedWallpaper)
			if not delOk then
				notification.create({
					title = "Could not delete dimmed wallpaper",
					description = delError,
					icon = "dialog-error",
					timeout = 5000,
				})
			end
		end

		if moveOk then
			notification.create({
				title = "Wallpaper archived",
				description = wallpaper,
				timeout = 5000,
			})
		end
	end
end

M.archiveCurrent = archiveCurrent
M.toggleDimmed = toggleDimmed
M.updateDimmed = updateDimmed
M.randomWallpaper = randomWallpaper

return M
