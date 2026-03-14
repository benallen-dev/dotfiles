-- Custom commands etc etc

-- I am so tired of W not being an editor command
vim.cmd("command! W write")

-- Use the asciifier tool I made to make big text ezpz
-- Requires installation of the asciifier tool
vim.api.nvim_create_user_command('Asciify', function(opts)
	local prefix = vim.bo.commentstring:gsub("%%s", "")
	local output = vim.fn.system { "asciifier", "-p", prefix, opts.args }

	local linenum = vim.api.nvim_win_get_cursor(0)[1]

	vim.api.nvim_buf_set_lines(0, linenum, linenum, false, vim.fn.split(output, "\n"))
end, { nargs = 1 })

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

-- Alias
vim.api.nvim_create_user_command('BC', function(opts)
	vim.cmd('BlockComment ' .. opts.args)
end, { nargs = '+' })
