vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { desc = "Yank into system clipboard" })

vim.keymap.set({'n', 'i', 'v'}, '<S-CR>', '<Nop>', { desc = "Disable shift-enter from which-key" })

-- Belongs elsewhere but here for now
vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.code_action() end, {desc = "List code actions"})
