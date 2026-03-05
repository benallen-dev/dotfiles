return {
	'hrsh7th/nvim-cmp',
	as = 'nvim-cmp',
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp', opts = {} },           -- Required
		{ 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- function argument hints
		{ 'brenoprata10/nvim-highlight-colors', opts = {} },
	},
	opts = {
		-- mapping = {
		-- 	['<Tab>'] = require('nvim-cmp').mapping.confirm({ select = true }),
		-- 	['<Down>'] = require('nvim-cmp').mapping.select_next_item(),
		-- 	['<Up>'] = require('nvim-cmp').mapping.select_prev_item(),
		-- },
		window = {
			completion = {
				border = 'rounded',
				bg = 'none',
				winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
			},
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'luasnip' },
		},
		-- formatting = {
		-- 	format = require("nvim-highlight-colors").format
		-- }

	}
}
