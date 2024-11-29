require("benallen.packer")
require("benallen.custom")
require("benallen.settings")
require("benallen.remap")
require("benallen.godot")

-- Shamelessly stolen from ThePrimagen. Again.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

