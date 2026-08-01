local M = {}

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
function M.gh(repo)
	return "https://github.com/" .. repo
end

--- Load and require all Lua modules from a directory.
---
--- Scans a directory for .lua files and requires each one.
--- Useful for auto-loading plugin or configuration modules.
---
--- @param dirname string Directory name relative to config/lua (e.g., "plugins")
--- @return nil
---
--- @example
--- M.requireAll("plugins")  -- Loads all .lua files in ~/.config/nvim/lua/plugins/
---
--- @note
--- - Follows symlinks
--- - Requires all .lua files including init.lua
--- - Module path derived from dirname (e.g., file.lua → dirname.file)
function M.requireAll(dirname)
	-- This code was adapted from kickstart.nvim to load all files in a dir
	-- https://github.com/nvim-lua/kickstart.nvim/blob/b01d0527708d01b01c9f490dd6ad76d4f3166d0b/lua/custom/plugins/init.lua

	local plugins_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", dirname)
	for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
		if (type == "file" or type == "link") and file_name:match("%.lua$") then
			local module = file_name:gsub("%.lua$", "")
			require(dirname .. "." .. module)
		end
	end
end

return M
