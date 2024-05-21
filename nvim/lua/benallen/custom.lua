-- Custom commands etc etc

-- I am so tired of W not being an editor command
vim.cmd("command! W write")

-- Use the asciifier tool I made to make big text ezpz
-- Requires installation of the asciifier tool
vim.api.nvim_create_user_command('Asciify', function(opts)
	local prefix = vim.bo.commentstring:gsub("%%s", "")
	local output = vim.fn.system {"asciifier", "-p", prefix, opts.args}

	local linenum = vim.api.nvim_win_get_cursor(0)[1]

	vim.api.nvim_buf_set_lines(0, linenum, linenum, false, vim.fn.split(output, "\n"))
end, { nargs = 1})

-- Add a :we command for when treesitter loses the plot
vim.keymap.set("n", "<leader>we", function()
	vim.cmd("write")
	vim.cmd("edit")
end, {})

