vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Delete into system clipboard
vim.keymap.set("n", "<leader>d", "\"+d")


-- Sick primeagen mappings -- 

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor position when using "J"
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in center when using Ctrl-U/D
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Paste without overwriting paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Replace symbol
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Reset search highlight
vim.keymap.set("n", "<leader>/", ":let @/ = \"\"<CR>")

-- Comment out lines
vim.keymap.set({"n","v"}, "<C-_>", ":Commentary<CR>")

-- Go error handling that I just stole from ThePrimeagen
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<ESC>Oreturn err<ESC>")

