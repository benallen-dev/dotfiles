local requireAll = require("utils").requireAll

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

requireAll("options")

require("core.diagnostic")
require("core.telescope")
require("core.lsp")
require("core.formatting")
require("core.autocomplete")
require("core.treesitter")

requireAll("autocommands")
requireAll("commands")
requireAll("keymaps")
requireAll("plugins")
