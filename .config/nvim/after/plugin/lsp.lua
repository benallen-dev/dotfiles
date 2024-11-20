local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

local lspconfig = require('lspconfig')
-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- Add templ to tailwind lsp filetype list
lspconfig.tailwindcss.setup({
	filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" }
})

lsp.set_preferences({
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- Primeagen's keymaps
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
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
end)

lsp.setup()

local cmp = require('cmp')
cmp.setup({
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	},
	window = {
		completion = {
			border = 'rounded',
			bg = 'none',
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = 'rounded',
		},
	},
})
-- nvim-cmp setup
-- local luasnip = require 'luasnip'
-- local cmp = require 'cmp'

-- cmp.setup {
--   sources = {
--     { name = 'nvim_lsp_signature_help' }
--   }
-- }
-- cmp.setup {
-- 	snippet = {
-- 		expand = function(args)
-- 			luasnip.lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		-- ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
-- 		-- ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
-- 		-- C-b (back) C-f (forward) for snippet placeholder navigation.
-- 		-- ['<C-Space>'] = cmp.mapping.complete(),
-- 		['<CR>'] = cmp.mapping.confirm {
-- 			behavior = cmp.ConfirmBehavior.Replace,
-- 			select = true,
-- 		},
-- 		['<Tab>'] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_next_item()
-- 			elseif luasnip.expand_or_jumpable() then
-- 				luasnip.expand_or_jump()
-- 			else
-- 				fallback()
-- 			end
-- 		end, { 'i', 's' }),
-- 		['<S-Tab>'] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_prev_item()
-- 			elseif luasnip.jumpable(-1) then
-- 				luasnip.jump(-1)
-- 			else
-- 				fallback()
-- 			end
-- 		end, { 'i', 's' }),
-- 	}),
-- 	sources = {
-- 		{ name = 'nvim_lsp' },
-- 		{ name = 'luasnip' },
-- 	},
-- }
