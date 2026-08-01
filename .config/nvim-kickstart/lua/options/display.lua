-- Show highlighted column
vim.o.colorcolumn = "80"
-- vim.o.textwidth = 80
-- vim.o.colorcolumn = "+0"

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show sign column on the left
vim.o.signcolumn = "yes"

-- Set default border style of floating windows
vim.o.winborder = "rounded"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars = {
	extends = "",
	lead = " ",
	nbsp = "␣",
	precedes = "",
	tab = " ",
	trail = "·",
}

vim.opt.tabstop = 4
vim.o.shiftwidth = 4 -- how much to indent when pressing tab
-- vim.o.softtabstop = 4
-- vim.o.expandtab = false
-- vim.o.smarttab = true

vim.o.wrap = false
vim.o.linebreak = true -- that way if you do :set wrap, it will wrap correctly

-- Enable break indent
vim.o.breakindent = true
