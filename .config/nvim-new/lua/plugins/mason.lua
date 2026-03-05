return {
	{
		"mason-org/mason-lspconfig.nvim",
		enabled = false,
		opts = {
		ensure_installed = {
			'lua_ls',
			'bashls',
			'gopls',
			'html',
			'htmx',
			'hyprls',
			'ts_ls',
		},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	}
}
