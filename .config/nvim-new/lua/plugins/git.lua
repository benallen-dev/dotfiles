return {
	{
		'tpope/vim-fugitive',
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
			vim.keymap.set("n", "<leader>gf", function()
				vim.cmd("Git pull")
			end, { desc = "Git pull" })
			vim.keymap.set("n", "<leader>gp", function()
				vim.cmd("Git push")
			end, { desc = "Git push" })
		end
	}
}
