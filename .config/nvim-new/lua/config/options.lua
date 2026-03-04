-- This file should be included before lazy.nvim

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Aesthetics
vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.o.winborder = "rounded"

-- Sign / line number column
vim.opt.signcolumn = "yes"			-- Always show sign column
vim.opt.nu = true					-- Show line numbers	
vim.opt.relativenumber = true		-- Show relative line numbers
vim.opt.scrolloff = 10				-- Keep 10 lines above and below cursor

-- Character / line width behaviour
vim.opt.tabstop = 4					-- how many spaces to show for \t
vim.opt.softtabstop = -1			-- follow shiftwidth
vim.opt.shiftwidth = 4				-- alignment of tabs every N spaces
vim.opt.expandtab = false			-- use \t instead of spaces

vim.opt.wrap = false
vim.opt.linebreak = true -- that way if you do :set wrap, it will wrap correctly
vim.opt.colorcolumn = "80"

-- Search highlight
vim.opt.hlsearch = true								-- Highlight search results
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')	-- Clear search results on ESC

-- Whitespace character display
vim.opt.list = true
vim.opt.listchars = {
	tab = " ",
	trail = "",
	extends = "",
	precedes = "",
	-- eol = "󰌑",
	-- lead = " ",
}

