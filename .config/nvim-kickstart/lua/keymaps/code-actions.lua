vim.keymap.set("n", "<leader>k", function()
	vim.lsp.buf.code_action()
end, {desc = "List code actions"})
