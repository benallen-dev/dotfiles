return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	opts = {
		indent = { enable = true },
		highlight = {
			enable = true,
			disable = { "markdown" },
			additional_vim_regex_highlighting = false,
		},
		folds = { enabled = true },


		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = { "javascript", "typescript", "html", "css", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,
	}
}
