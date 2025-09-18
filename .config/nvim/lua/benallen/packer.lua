-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use({
		'ellisonleao/gruvbox.nvim',
		as = 'gruvbox',
		-- config = function()
		-- 	vim.cmd('colorscheme gruvbox')
		-- end
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin"
	})

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	use('theprimeagen/harpoon')

	use('mbbill/undotree')

	-- Git interaction
	use("tpope/vim-fugitive")

	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ 'mason-org/mason.nvim' },
			{ 'mason-org/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },           -- Required
			{ 'hrsh7th/cmp-nvim-lsp' },       -- Required
			{ 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- function argument hints
			{ "L3MON4D3/LuaSnip",
				run = "make install_jsregexp"
			}, -- Required

			-- LSP sources
			{ 'hrsh7th/cmp-copilot' }, -- Integrate copilot.vim
		}
	}

	-- Status updates for LSP
	use('j-hui/fidget.nvim')

	-- nvim-tree and icons
	use('nvim-tree/nvim-tree.lua')
	use('nvim-tree/nvim-web-devicons')

	-- -- Inline colour previews
	-- use('NvChad/nvim-colorizer.lua')

	-- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use {
		'laytan/tailwind-sorter.nvim',
		requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
		run = 'cd formatter && npm i && npm run build',
	}

	-- Github Copilot
	use('github/copilot.vim')

	-- Discord rich presence
	use('andweeb/presence.nvim')

	-- GitSigns (show git changes in the gutter)
	use('lewis6991/gitsigns.nvim')

	-- Toggle comments
	use('tpope/vim-commentary')

	-- Go templ support
	use('tjdevries/templ.nvim')

	-- treesitter-context
	use('nvim-treesitter/nvim-treesitter-context')

	-- Hide long css classnames
	use {
		'razak17/tailwind-fold.nvim',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('tailwind-fold').setup({
				ft = { 'html', 'typescriptreact', 'php', 'templ', 'svelte', 'astro', 'vue' }
			})
		end
	}

	use {
		'folke/which-key.nvim',
		config = function()
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		end,
		setup = function()
			-- Define your custom key bindings here
			vim.api.nvim_set_keymap('n', '<leader>?', [[:lua require("which-key").show({ global = false })<CR>]],
				{ noremap = true, silent = true, desc = "Buffer Local Keymaps (which-key)" })
		end
	}

	use {
		'romainl/vim-cool',
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
