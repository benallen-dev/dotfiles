require("benallen.packer")
require("benallen.custom")
require("benallen.settings")
require("benallen.remap")

-- Shamelessly stolen from ThePrimagen. Again.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.hl.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

local close_quickfix = augroup('CloseQuickfix', {})
autocmd('FileType', {
	group = close_quickfix,
	pattern = 'qf',
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			vim.cmd("cc")
			vim.cmd("cclose")
		end)
	end
})
