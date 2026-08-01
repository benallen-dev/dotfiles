local gh = require("utils").gh

-- See `:help gitsigns` to understand what each configuration key does.
-- Adds git related signs to the gutter, as well as utilities for managing changes
vim.pack.add({ gh("lewis6991/gitsigns.nvim") })

require("gitsigns").setup({
	signs = {
		add = { text = "+" }, ---@diagnostic disable-line: missing-fields
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
		untracked = { text = "┆" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
		delay = 600,
		ignore_whitespace = false,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "<leader>gbl", function()
			gs.blame_line({ full = true })
		end, { desc = "[G]it [B]lame [L]ine" })

		map("n", "<leader>gbf", function()
			gs.blame()
		end, { desc = "[G]it [B]lame [F]ile" })
	end,
})
