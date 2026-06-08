return {
	'theprimeagen/harpoon',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

		vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end, { desc = "Goto Harpoon file 1"})
		vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end, { desc = "Goto Harpoon file 2"})
		vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end, { desc = "Goto Harpoon file 3"})
	end
}
