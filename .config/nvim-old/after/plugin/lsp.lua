local mason = require("mason")
mason.setup({})

local masonLspconfig = require("mason-lspconfig")
masonLspconfig.setup({
	automatic_installation = false,
	automatic_setup = true,
	automatic_enable = true,
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

-- local lspconfig = require('lspconfig')
-- -- (Optional) Configure lua language server for neovim
-- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- -- Add templ & md to tailwind lsp filetype list
-- lspconfig.tailwindcss.setup({
-- 	filetypes = { "md", "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" }
-- })

-- lsp.set_preferences({
-- 	sign_icons = {
-- 		error = 'E',
-- 		warn = 'W',
-- 		hint = 'H',
-- 		info = 'I'
-- 	}
-- })

-- Set global rounded border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'

  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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

local blackOrWhiteFg = function(r, g, b)
	return ((r * 0.299 + g * 0.587 + b * 0.114) > 186) and '#000000' or '#ffffff'
end
-- choose your icon chars
local icons = {
	Class = '■',
	Color = '',
	Constant = '',
	Constructor = '',
	Enum = '',
	EnumMember = '',
	Event = '',
	Field = '',
	File = '',
	Folder = '',
	Function = "f⒳",
	Interface = '',
	Keyword = '',
	Method = "",
	Module = '',
	Operator = '',
	Property = '',
	Reference = '',
	Snippet = '',
	Struct = '',
	Text = '',
	TypeParameter = '',
	Unit = '',
	Value = '',
	Variable = '',
}
function hex_to_rgb(hex)
	-- Remove the hash sign if present
	hex = hex:gsub("#", "")

	-- Convert each pair of characters to a byte (0-255)
	local r, g, b = tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))

	return { r = r, g = g, b = b }
end

local cmp = require('cmp')
cmp.setup({
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	},
	window = {
		default_options = {
			border = 'rounded',
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		completion = {
			border = 'rounded',
			bg = 'none',
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = 'rounded',
		},
	},
	-- sources = {
	-- 	{ name = 'nvim_lsp' },
	-- 	{ name = 'luasnip' },
	-- 	{ name = 'buffer' },
	-- },
	-- sources = {
	-- 	{ name = 'nvim_lsp', group_index = 1 },
	-- 	{ name = 'luasnip',  group_index = 1 },
	-- 	{ name = 'buffer' },
	-- },


	formatting = {
		format = function(entry, vim_item)
			if vim_item.kind == 'Color' and entry.completion_item.documentation then
				local doc = entry.completion_item.documentation

				if type(doc) == "table" then
					doc = doc.value -- Assuming 'variable' has a field named 'value'
				end

				-- Tailwind colours are hexes
				-- local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+) (%d+) (%d+)')
				--

				local rgb = hex_to_rgb(doc)
				local r = rgb.r
				local g = rgb.g
				local b = rgb.b

				if r then
					local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
					local group = 'Tw_' .. color
					if vim.fn.hlID(group) < 1 then
						-- vim.api.nvim_set_hl(0, group, { bg = blackOrWhiteFg(r, g, b), fg = '#' .. color })
						vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
					end
					vim_item.kind = ' ' .. icons[vim_item.kind] .. ' '
					vim_item.kind_hl_group = group
					return vim_item
				end
			end
			-- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
			-- or just show the icon
			vim_item.kind = icons[vim_item.kind] and icons[vim_item.kind] or vim_item.kind
			return vim_item
		end,
	}
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
