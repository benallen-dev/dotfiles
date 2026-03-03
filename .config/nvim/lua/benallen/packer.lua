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
			{ 'mason-org/mason.nvim' },  -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },           -- Required
			{ 'hrsh7th/cmp-nvim-lsp' },       -- Required
			{ 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- function argument hints
			{ "L3MON4D3/LuaSnip",
				run = "make install_jsregexp"
			}, -- Required

			-- LSP sources
			-- { 'hrsh7th/cmp-copilot' }, -- Integrate copilot.vim
		}
	}

	-- Status updates for LSP
	use('j-hui/fidget.nvim')

	-- nvim-tree and icons
	use('nvim-tree/nvim-tree.lua')
	use('nvim-tree/nvim-web-devicons')

	-- -- Inline colour previews
	use('brenoprata10/nvim-highlight-colors')
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
	-- use('github/copilot.vim')

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

  use {
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

            -- For logging that is to a file if you wish to trace through requests
            -- for reporting bugs, i would not rely on this, but instead the provided
            -- logging mechanisms within 99.  This is for more debugging purposes
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
			_99.setup({
                -- provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
				--
				model = 'opencode/big-pickle',
				-- logger = {
				-- 	level = _99.DEBUG,
				-- 	path = "/tmp/" .. basename .. ".99.debug",
				-- 	print_on_error = true,
				-- },
                -- When setting this to something that is not inside the CWD tools
                -- such as claude code or opencode will have permission issues
                -- and generation will fail refer to tool documentation to resolve
                -- https://opencode.ai/docs/permissions/#external-directories
                -- https://code.claude.com/docs/en/permissions#read-and-edit
                tmp_dir = "./tmp",

                --- Completions: #rules and @files in the prompt buffer
                completion = {
                    -- I am going to disable these until i understand the
                    -- problem better.  Inside of cursor rules there is also
                    -- application rules, which means i need to apply these
                    -- differently
                    -- cursor_rules = "<custom path to cursor rules>"

                    --- A list of folders where you have your own SKILL.md
                    --- Expected format:
                    --- /path/to/dir/<skill_name>/SKILL.md
                    ---
                    --- Example:
                    --- Input Path:
                    --- "scratch/custom_rules/"
                    ---
                    --- Output Rules:
                    --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
                    --- ... the other rules in that dir ...
                    ---
                    custom_rules = {
                      "scratch/custom_rules/",
                    },

                    --- Configure @file completion (all fields optional, sensible defaults)
                    files = {
                        -- enabled = true,
                        -- max_file_size = 102400,     -- bytes, skip files larger than this
                        -- max_files = 5000,            -- cap on total discovered files
                        -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
                    },
                    --- File Discovery:
                    --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
                    --- - Non-git repos: Falls back to filesystem scanning with manual excludes
                    --- - Both methods apply the configured `exclude` list on top of gitignore

                    --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
                    source = "native", -- "native" (default), "cmp", or "blink"
                },

                --- WARNING: if you change cwd then this is likely broken
                --- ill likely fix this in a later change
                ---
                --- md_files is a list of files to look for and auto add based on the location
                --- of the originating request.  That means if you are at /foo/bar/baz.lua
                --- the system will automagically look for:
                --- /foo/bar/AGENT.md
                --- /foo/AGENT.md
                --- assuming that /foo is project root (based on cwd)
				md_files = {
					"AGENT.md",
				},
			})

            -- take extra note that i have visual selection only in v mode
            -- technically whatever your last visual selection is, will be used
            -- so i have this set to visual mode so i dont screw up and use an
            -- old visual selection
            --
            -- likely ill add a mode check and assert on required visual mode
            -- so just prepare for it now
			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end, { desc = "99 visual" })

			vim.keymap.set("v", "<leader>99", function()
				require('99').visual_prompt()
			end, { desc = "99: Visual prompt" })
            --- if you have a request you dont want to make any changes, just cancel it
			vim.keymap.set("n", "<leader>9x", function()
				_99.stop_all_requests()
			end, {desc = "99 stop all requests" })

			vim.keymap.set("n", "<leader>9s", function()
				_99.search()
			end, { desc = "99 search" })
		end,
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
