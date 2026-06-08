local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values

local function grouped_grep_picker()
	local search_string = vim.fn.input("Grep > ")
	if search_string == "" then
		return
	end

	-- Collect all matches from rg
	local handle = io.popen(
		string.format("rg --with-filename --line-number '%s' 2>/dev/null", search_string)
	)
	local output = handle:read("*a")
	handle:close()

	-- Group by filename while preserving order
	local file_groups = {}
	local file_order = {}
	local current_order = 0

	for line in output:gmatch("[^\n]+") do
		local parts = vim.split(line, ":", { plain = true })
		if #parts >= 2 then
			local filename = parts[1]
			local lnum = tonumber(parts[2]) or 1
			local text = table.concat(parts, ":", 3)

			if not file_groups[filename] then
				file_groups[filename] = {
					count = 0,
					lines = {},
					first_seen = current_order,
				}
				current_order = current_order + 1
				table.insert(file_order, filename)
			end

			file_groups[filename].count = file_groups[filename].count + 1
			table.insert(file_groups[filename].lines, { lnum = lnum, text = text, full_line = line })
		end
	end

	-- Create entries preserving grep's order
	local entries = {}
	for _, filename in ipairs(file_order) do
		local group = file_groups[filename]
		table.insert(entries, {
			filename = filename,
			count = group.count,
			lines = group.lines,
			display = string.format("[%d] %s", group.count, filename),
			ordinal = filename,
		})
	end

	if #entries == 0 then
		vim.notify("No matches found", vim.log.levels.INFO)
		return
	end

	-- Create custom preview for grouped results
	local previewer = require("telescope.previewers").new_buffer_previewer({
		define_preview = function(self, entry)
			local lines = {}
			for _, match in ipairs(entry.lines) do
				table.insert(lines, match.lnum .. ":" .. match.text)
			end
			vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
			require("telescope.previewers.utils").highlighter(
				self.state.bufnr,
				"text",
				require("telescope.config").values.preview_cutoff
			)
		end,
	})

	local picker = pickers.new({}, {
		prompt_title = "Project grep (grouped by file)",
		finder = finders.new_table({
			results = entries,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.display,
					ordinal = entry.ordinal,
					filename = entry.filename,
					lnum = entry.lines[1].lnum,
				}
			end,
		}),
		previewer = previewer,
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			local actions = require("telescope.actions")
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = actions.get_selected_entry()
				if selection then
					vim.cmd("edit " .. selection.filename)
				end
			end)
			return true
		end,
	})

	picker:find()
end

vim.keymap.set("n", "<leader>pf", grouped_grep_picker, { noremap = true, silent = true })
