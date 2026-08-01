-- These mappings were 'borrowed' from ThePrimeagen

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor position when using "J"
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in center when using Ctrl-U/D
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
