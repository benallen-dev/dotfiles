local builtin = require('telescope.builtin')

-- (f)ile search
vim.keymap.set('n', '<leader>f', function()
	builtin.find_files({ find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' } });
end)
-- (g)git search, not used as often therefore double key is ok
vim.keymap.set("n", "<leader>gg", builtin.git_files, {})

-- search (i)nside file
-- vim.keymap.set('n', '<leader>i', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)

vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

-- Old (p)roject (s)earch
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- find something
vim.keymap.set('n', '<leader>pp', function()
	builtin.grep_string({ search = "" });
end)

vim.keymap.set('n', '<leader>pf', function()
	builtin.find_files({ find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' } });
	--	builtin.find_files({ hidden = true });
end)
