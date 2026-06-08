return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = {
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),
				},
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
					},
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
				},
				formatting = {
					format = require("nvim-highlight-colors").format,
				},
			})
		end,
	},

	-- Highlight colors (inline color previews)
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},


	-- LSP (Mason for installing servers)

		{
		"mason-org/mason-lspconfig.nvim",
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
	-- {
	-- 	'mason-org/mason.nvim',
	-- 	cmd = "Mason",
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	config = function()
	-- 		require('mason').setup()
	-- 	end,
	-- },

	-- -- Mason LSP Config (bridge between Mason and built-in LSP)
	-- {
	-- 	'mason-org/mason-lspconfig.nvim',
	-- 	dependencies = { 'mason-org/mason.nvim' },
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	config = function()
	-- 		require('mason-lspconfig').setup()
	-- 	end,
	-- },

}
