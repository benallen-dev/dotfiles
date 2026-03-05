vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })

vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { desc = "Yank into system clipboard" })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Belongs elsewhere but here for now
vim.keymap.set({'c', 'n', 'i', 'v'}, '<S-CR>', '<Nop>', { desc = "Disable shift-enter from which-key" })
vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.code_action() end, {desc = "List code actions"})
