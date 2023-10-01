local prettier = require("prettier")

prettier.setup({
	bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
	cli_options = {
		use_tabs = true,
		jsx_single_quote = true,
		single_quote = true,
		single_attribute_per_line = true,
	},
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})

vim.keymap.set("n", "<leader>p", vim.cmd.Prettier)
