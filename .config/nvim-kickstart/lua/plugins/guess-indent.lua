local gh = require("utils").gh

-- For example, lets say we want to install `guess-indent.nvim` - a plugin for
-- automatically detecting and setting the indentation.
--
-- We first install it from https://github.com/NMAC427/guess-indent.nvim
-- and then call its `setup()` function to start it with default settings.
vim.pack.add({ gh("NMAC427/guess-indent.nvim") })

require("guess-indent").setup({})
