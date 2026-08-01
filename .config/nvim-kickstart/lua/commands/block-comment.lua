--- Creates a block comment with auto-padding dashes
vim.api.nvim_create_user_command('BlockComment', function(opts)
	local text = opts.args
	local prefix = " ── "
	local total_length = 80

	local cslen = #vim.bo.commentstring:gsub("%%s", "")

	-- Calculate how many dashes we need at the end
	local available_for_dashes = total_length - #prefix - #text - cslen

	-- Build the line
	local line = prefix .. text .. " " .. string.rep("─", available_for_dashes)
	local output = vim.bo.commentstring:gsub("%%s", line)

	local linenum = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, linenum, linenum, false, { output })
end, { nargs = '+' })
