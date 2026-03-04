-- Nvim-tree: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.options")

require("config.lazy")

require("config.autocmds")
require("config.keymaps")
