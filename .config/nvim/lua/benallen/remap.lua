vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Delete into system clipboard
vim.keymap.set("n", "<leader>d", "\"+d", { desc = "Delete into system clipboard" })

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
vim.keymap.set("x", "<leader>pp", "\"_dP", { desc = "Paste without overwriting \" register" })

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank into system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank into system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank into system clipboard" })

-- Replace symbol
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename symbol" })

-- LSP Rename
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })

-- Make executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x" })

-- Comment out lines
vim.keymap.set({ "n", "v" }, "<C-_>", ":Commentary<CR>", { desc = "Comment" })
vim.keymap.set({ "n", "v" }, "<leader>/", ":Commentary<CR>", { desc = "Comment" })

-- Go error handling that I just stole from ThePrimeagen
vim.keymap.set("n", "<leader>ee", "Oif err != nil {<CR>}<ESC>Oreturn err<ESC>", { desc = "Add go error check" })

-- Easier way of exiting insert mode
vim.keymap.set("i", "<C-j>", "<ESC>")
vim.keymap.set("i", "jj", "<ESC>")

-- Add a :we command for when treesitter loses the plot
vim.keymap.set("n", "<leader>we", function()
	vim.cmd("write")
	vim.cmd("edit")
end, {desc = "Write and reopen"})

vim.keymap.set("n", "<leader>k", function()
	vim.lsp.buf.code_action()
end, {desc = "List code actions"})
