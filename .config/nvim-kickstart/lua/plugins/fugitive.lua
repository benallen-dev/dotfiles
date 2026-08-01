local gh = require("utils").gh

vim.pack.add({ gh("tpope/vim-fugitive") })

vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
vim.keymap.set("n", "<leader>gf", ":Git pull<CR>", { desc = "[G]it pull ([F]etch)" })
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "[G]it [P]ush" })
