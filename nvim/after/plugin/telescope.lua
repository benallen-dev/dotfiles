local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function()
	builtin.find_files({  find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }});
	-- builtin.find_files({ hidden = true });
end)
vim.keymap.set('n', '<leader>j', function()
	builtin.find_files({  find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }});
	-- builtin.find_files({ hidden = true });
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>f", builtin.git_files, {})

