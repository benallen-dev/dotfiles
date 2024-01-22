-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

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
		config = function()
			vim.cmd('colorscheme gruvbox')
		end
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
			{ 'neovim/nvim-lspconfig' },    -- Required
			{ 'williamboman/mason.nvim' },  -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	}

	-- nvim-tree and icons
	use('nvim-tree/nvim-tree.lua')
	use('nvim-tree/nvim-web-devicons')

	-- Inline colour previews
	use('NvChad/nvim-colorizer.lua')

	-- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- Prettier
	use {
		'MunifTanjim/prettier.nvim',
		requires = {
			{ 'neovim/nvim-lspconfig' },
			{ 'jose-elias-alvarez/null-ls.nvim' }
		}
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
end)
