vim.diagnostic.config({
	signs = {
		-- text = {
		-- 	[vim.diagnostic.severity.ERROR] = '',
		-- 	[vim.diagnostic.severity.WARN] = '',
		-- },
		-- linehl = {
		-- 	[vim.diagnostic.severity.ERROR] = 'DiagnosticError',
		-- },	
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
			[vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
		},
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local opts = { buffer = args.buf, remap = false }

		-- Primeagen's keymaps
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
			{ buffer = args.buf, remap = false, desc = "Go to definition" })
		vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
		vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
		vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

		-- These are mine
		vim.keymap.set("n", "<leader>lf", function()
			print("Formatting...")
			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
			print("Formatted")
		end, opts)

		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references)
		vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float(0, { scope = "line" }) end, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
	end,
})

vim.lsp.enable({
	'ast_grep',
	'bashls',
	'gopls',
	'htmx',
	'hyprls',
	'lua_ls',
	'pylsp',
	'pyright',
	'tailwindcss',
	'ts_ls',
})

local cmp = require('cmp')
cmp.setup({
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		['<Down>'] = cmp.mapping.select_next_item(),
		['<Up>'] = cmp.mapping.select_prev_item(),
	},
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
})
