local gh = require("utils").gh

vim.pack.add({ gh("rafcamlet/nvim-luapad") })
require("luapad").setup({})
