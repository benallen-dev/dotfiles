vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gf", function ()
	vim.cmd("Git pull")
end)
vim.keymap.set("n", "<leader>gp", function ()
	vim.cmd("Git push")
end)