vim.opt.signcolumn = "yes"							-- Always show sign column
vim.opt.nu = true									-- Show line numbers	
vim.opt.relativenumber = true						-- Show relative line numbers
vim.opt.scrolloff = 10								-- Keep 10 lines above and below cursor

vim.opt.hlsearch = true								-- Highlight search results
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')	-- Clear search results on ESC

vim.opt.termguicolors = true
vim.g.have_nerd_font = true

vim.opt.list = true
vim.opt.listchars = {
	-- eol = "󰌑",
	tab = " ",
	trail = "",
	-- lead = "",
	lead = " ",
	extends = "",
	precedes = "",
}

vim.opt.smartindent = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.wrap = false

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false

vim.opt.colorcolumn = "80"
