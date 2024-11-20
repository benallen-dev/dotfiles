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
vim.opt.colorcolumn = "80"

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.fillchars:append({fold = ' '})

-- Set colour for folds
local comment_fg = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg
vim.api.nvim_set_hl(0, 'Folded', { fg = comment_fg, bold = false })

function Custom_Foldtext()
	local line = vim.fn.getline(vim.v.foldstart)
	local num_lines = vim.v.foldend - vim.v.foldstart + 1
	local line_word = num_lines == 1 and ' line' or ' lines'

	local indent = string.match(line, "^[\t ]*")

	return string.gsub(indent, " ", "\t") .. '--- ' .. num_lines .. line_word .. ' ---'
end

vim.o.foldtext = 'v:lua.Custom_Foldtext()'
