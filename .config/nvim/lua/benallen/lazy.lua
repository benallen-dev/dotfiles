-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
	-- CSV improvements
	{
	  "hat0uma/csvview.nvim",
	  ---@module "csvview"
	  ---@type CsvView.Options
	  opts = {
		parser = { comments = { "#", "//" } },
		keymaps = {
		  -- Text objects for selecting fields
		  textobject_field_inner = { "if", mode = { "o", "x" } },
		  textobject_field_outer = { "af", mode = { "o", "x" } },
		  -- Excel-like navigation:
		  -- Use <Tab> and <S-Tab> to move horizontally between fields.
		  -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
		  -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
		  jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
		  jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
		  jump_next_row = { "<Enter>", mode = { "n", "v" } },
		  jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
		},
	  },
	  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},

	-- Colorschemes (load immediately for UI)
	{
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			local hostname = vim.uv.os_gethostname()
			if hostname ~= "devbox" then
				require('gruvbox').setup({
					undercurl = true,
					underline = true,
					bold = true,
					italic = {
						strings = false,
						comments = true,
						operators = false,
						folds = true,
					},
					strikethrough = true,
					invert_selection = false,
					invert_signs = false,
					invert_tabline = false,
					invert_intend_guides = false,
					inverse = true,
					contrast = "soft",
					palette_overrides = {},
					overrides = {},
					dim_inactive = false,
					transparent_mode = true,
				})
				vim.cmd("colorscheme gruvbox")
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local hostname = vim.uv.os_gethostname()
			if hostname == "devbox" then
				require("catppuccin").setup({
					flavour = "auto",
					background = {
						light = "latte",
						dark = "mocha",
					},
					transparent_background = true,
					show_end_of_buffer = false,
					term_colors = false,
					dim_inactive = {
						enabled = false,
						shade = "dark",
						percentage = 0.15,
					},
					no_italic = false,
					no_bold = false,
					no_underline = false,
					styles = {
						comments = { "italic" },
						conditionals = { "italic" },
						loops = {},
						functions = {},
						keywords = {},
						strings = {},
						variables = {},
						numbers = {},
						booleans = {},
						properties = {},
						types = {},
						operators = {},
					},
					color_overrides = {},
					custom_highlights = {},
					default_integrations = true,
					auto_integrations = false,
					integrations = {
						cmp = true,
						gitsigns = true,
						nvimtree = true,
						treesitter = true,
						notify = false,
						mini = {
							enabled = true,
							indentscope_color = "",
						},
					},
				})
				vim.cmd.colorscheme "catppuccin"
			end
		end,
	},

	-- Treesitter (load immediately, needed by telescope previewer)
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
		config = function()
			require('nvim-treesitter').setup({})

		-- Install parsers (async, won't block startup after first install)
		require('nvim-treesitter').install({
			'javascript', 'typescript', 'html', 'css', 'lua', 'vim', 'vimdoc', 'query',
			'markdown', 'markdown_inline'
		})

			-- Enable treesitter highlighting for all supported filetypes
			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable treesitter-based indentation
			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	-- Treesitter context
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = { "BufReadPost", "BufNewFile" },
	},

	-- Telescope (lazy-load on keybinds)
	{
		'nvim-telescope/telescope.nvim',
		branch = 'master',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader>f', function()
				require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' } })
			end, desc = "Find files" },
			{ '<leader>gg', function() require('telescope.builtin').git_files() end, desc = "Git files" },
			{ '<leader>vh', function() require('telescope.builtin').help_tags() end, desc = "Help tags" },
			{ '<leader>ps', function()
				require('telescope.builtin').grep_string({ 
					search = vim.fn.input("Grep > "),
					use_regex = true,
			        additional_args = { "--glob", "!**/dist/*" }
				})
			end, desc = "Project search" },
			{ '<leader>pp', function()
				require('telescope.builtin').grep_string({ search = "" })
			end, desc = "Project grep" },
		},
		cmd = "Telescope",
	},

	-- Harpoon (lazy-load on keybinds)
	{
		'theprimeagen/harpoon',
		keys = {
			{ '<leader>a', function() require("harpoon.mark").add_file() end, desc = "Harpoon add file" },
			{ '<C-e>', function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
			{ '<C-j>', function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon file 1" },
			{ '<C-k>', function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon file 2" },
			{ '<C-l>', function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon file 3" },
		},
	},

	-- Undotree (lazy-load on command/keybind)
	{
		'mbbill/undotree',
		keys = {
			{ '<leader>u', vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
		},
		cmd = "UndotreeToggle",
	},

	-- Git plugins
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
		keys = {
			{ '<leader>gs', vim.cmd.Git, desc = "Git status" },
			{ '<leader>gf', function() vim.cmd("Git pull") end, desc = "Git pull" },
			{ '<leader>gp', function() vim.cmd("Git push") end, desc = "Git push" },
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require('gitsigns').setup {
				signs = {
					add          = { text = '+' },
					change       = { text = '~' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '-' },
					untracked    = { text = '┆' },
				},
				signcolumn                   = true,
				numhl                        = false,
				linehl                       = false,
				word_diff                    = false,
				watch_gitdir                 = {
					follow_files = true
				},
				attach_to_untracked          = false,
				current_line_blame           = true,
				current_line_blame_opts      = {
					virt_text = true,
					virt_text_pos = 'right_align',
					delay = 600,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
				sign_priority                = 6,
				update_debounce              = 100,
				status_formatter             = nil,
				max_file_length              = 40000,
				preview_config               = {
					border = 'single',
					style = 'minimal',
					relative = 'cursor',
					row = 0,
					col = 1
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map('n', ']c', function()
						if vim.wo.diff then return ']c' end
						vim.schedule(function() gs.next_hunk() end)
						return '<Ignore>'
					end, { expr = true })

					map('n', '[c', function()
						if vim.wo.diff then return '[c' end
						vim.schedule(function() gs.prev_hunk() end)
						return '<Ignore>'
					end, { expr = true })

					map('n', '<leader>gh', gs.preview_hunk)
					map('n', '<leader>gb', function() gs.blame_line { full = true } end)
					map('n', '<leader>tb', gs.toggle_current_line_blame)
				end
			}
		end,
	},

	-- LSP (Mason for installing servers)
	{
		'mason-org/mason.nvim',
		cmd = "Mason",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require('mason').setup()
		end,
	},

	-- -- Mason LSP Config (bridge between Mason and built-in LSP)
	-- {
	-- 	'williamboman/mason-lspconfig.nvim',
	-- 	dependencies = { 'mason-org/mason.nvim' },
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	config = function()
	-- 		require('mason-lspconfig').setup()
	-- 	end,
	-- },

	-- Eslint config
	{
	  'esmuellert/nvim-eslint',
		config = function()
			require('nvim-eslint').setup({})
		  end,
	},

	-- Autocompletion (lazy-load on InsertEnter)
	{
		'hrsh7th/nvim-cmp',
		event = "InsertEnter",
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			{ 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
		},
		config = function()
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
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
					},
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'luasnip' },
				},
				formatting = {
					format = require("nvim-highlight-colors").format
				}
			})
		end,
	},

	-- Fidget (LSP progress, load on LspAttach)
	{
		'j-hui/fidget.nvim',
		event = "LspAttach",
		config = function()
			require('fidget').setup {
				progress = {
					display = {
						done_ttl = 5,
					},
				},
				notification = {
					window = {
						winblend = 0,
						border = "rounded"
					}
				}
			}
		end,
	},

	--99.nvim, because I am too lazy to copy-pasta
	{
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
				provider = _99.Providers.OpenCodeProvider,
				model = "github-copilot/claude-haiku-4.5",
				-- model = "claude-haiku-4.5",
				logger = {
					level = _99.DEBUG,
					path = "./tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
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

                    --- What autocomplete do you use.  We currently only
                    --- support cmp right now
                    source = "cmp" ,
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
			end)

            --- if you have a request you dont want to make any changes, just cancel it
			vim.keymap.set("n", "<leader>9x", function()
				_99.stop_all_requests()
			end)

			vim.keymap.set("n", "<leader>9s", function()
				_99.search()
			end)
		end,
	},	

	-- nvim-tree (load immediately, auto-open on startup)
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		lazy = false,
		keys = {
			{ '<C-b>', '<cmd>NvimTreeFocus<cr>', desc = "Focus file tree" },
			{ '<leader>b', '<cmd>NvimTreeToggle<cr>', desc = "Toggle file tree" },
		},
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
		config = function()
			function runSetup()

				local uis = vim.api.nvim_list_uis()
				local gwidth = uis[1] and uis[1].width or 80
				local gheight = uis[1] and uis[1].height or 24
				local width = math.floor(gwidth * 0.8)
				local height = math.floor(gheight * 0.8)

				require("nvim-tree").setup({
					sort_by = "case_sensitive",
					actions = {
						open_file = {
							quit_on_open = true,
						}
					},
					view = {
						relativenumber = true,
						float = {
							enable = true,
							open_win_config = {
								relative = "editor",
								width = width,
								height = height,
								row = (gheight - height) * 0.4,
								col = (gwidth - width) * 0.5,
							}
						}
					},
					renderer = {
						root_folder_label = false,
						group_empty = true,
						indent_markers = {
							enable = true,
							inline_arrows = true,
							icons = {
								corner = "└",
								edge = "│",
								item = "│",
								bottom = "─",
								none = " ",
							},
						},
						icons = {
							git_placement = "before",
							web_devicons = {
								file = {
									enable = true,
									color = true,
								},
								folder = {
									enable = false,
									color = true,
								}
							},
							glyphs = {
								default = "",
								symlink = "",
								bookmark = "󰆤",
								modified = "●",
								folder = {
									-- -- arrow_closed = "",
									-- -- arrow_open = "",
									-- default = "󰉋",
									-- open = "󰝰",
									-- empty = "󰉖",
									-- empty_open = "󰷏",
									-- symlink = "󱧮",
									-- symlink_open = "󱧮",
								},
								git = {
									unstaged = "󰏫",
									staged = "✓",
									unmerged = "",
									renamed = "➜",
									untracked = "★",
									deleted = "",
									ignored = "◌",
								},
							},
						},
					},
					modified = {
						enable = true,
						show_on_dirs = true,
						show_on_open_dirs = true,
					},
					update_focused_file = {
						enable = true,
						update_root = false,
						ignore_list = {},
					},
					filters = {
						dotfiles = false,
						git_ignored = false,
						custom = {
							"^\\.git$",
						}
					},
				})
			end

			-- Run setup on first init
			runSetup()

			-- Register a command to update the setup
			vim.api.nvim_create_user_command('NvimTreeResize', runSetup, { nargs = 0 })

			-- Auto-open nvim-tree on startup
			vim.api.nvim_create_autocmd("VimEnter", {

				callback = function()
					local bufname = vim.api.nvim_buf_get_name(0)

					if bufname:match("COMMIT_EDITMSG") or bufname:match("MERGE_MSG") or bufname:match("git%-rebase%-todo") then
						return
					end

					local args = vim.fn.argv()
					if #args == 0 or vim.fn.isdirectory(args[1]) == 1 then
						require("nvim-tree.api").tree.open()
					end
				end
			})
		end,
	},

	-- Web dev icons (load immediately, needed by nvim-tree)
	{ 'nvim-tree/nvim-web-devicons', lazy = false },

	-- Highlight colors (inline color previews)
	{
		'brenoprata10/nvim-highlight-colors',
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require('nvim-highlight-colors').setup({})
		end,
	},

	-- Lualine (status line - load immediately for UI)
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = "VeryLazy",
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
				inactive_sections = {},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {
					'fugitive',
					'nvim-tree'
				}
			}
		end,
	},

	-- Tailwind sorter
	{
		'laytan/tailwind-sorter.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
		build = 'cd formatter && npm i && npm run build',
		ft = { "html", "templ", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro", "svelte", "vue", "php" },
		keys = {
			{ '<leader>ts', ':TailwindSort<CR>', desc = "Sort Tailwind classes" },
		},
		config = function()
			require('tailwind-sorter').setup({
				on_save_enabled = false,
				on_save_pattern = { '*.templ', '*.html', '*.js', '*.jsx', '*.tsx', '*.twig', '*.hbs', '*.php', '*.heex', '*.astro', '*.md' },
				node_path = 'node',
			})
		end,
	},

	-- Tailwind fold (hide long classnames)
	{
		'razak17/tailwind-fold.nvim',
		lazy = false,
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		ft = { 'html', 'typescriptreact', 'php', 'templ', 'svelte', 'astro', 'vue' },
		config = function()
			require('tailwind-fold').setup({
				ft = { 'html', 'typescriptreact', 'php', 'templ', 'svelte', 'astro', 'vue' }
			})
		end,
	},

	-- Github Copilot
	{
		'github/copilot.vim',
		event = "InsertEnter",
		config = function()
			vim.g.copilot_enabled = false
		end,
	},

	-- Discord rich presence
	{
		'andweeb/presence.nvim',
		event = "VeryLazy",
		config = function()
			require("presence").setup({
				auto_update         = true,
				neovim_image_text   = "I use vim btw",
				main_image          = "neovim",
				client_id           = "793271441293967371",
				log_level           = nil,
				debounce_timeout    = 10,
				enable_line_number  = false,
				blacklist           = {},
				buttons             = true,
				file_assets         = {},
				show_time           = true,
				editing_text        = "Editing %s",
				file_explorer_text  = "Browsing %s",
				git_commit_text     = "Committing changes",
				plugin_manager_text = "Managing plugins",
				reading_text        = "Reading %s",
				workspace_text      = "Working on %s",
				line_number_text    = "Line %s out of %s",
			})
		end,
	},

	-- Toggle comments
	{
		'tpope/vim-commentary',
		keys = {
			{ '<C-_>', ':Commentary<CR>', mode = { 'n', 'v' }, desc = "Toggle comment" },
			{ '<leader>/', ':Commentary<CR>', mode = { 'n', 'v' }, desc = "Toggle comment" },
		},
		cmd = "Commentary",
	},

	-- Which-key
	{
		'folke/which-key.nvim',
		event = "VeryLazy",
		config = function()
			require("which-key").setup({})
		end,
		keys = {
			{ '<leader>?', function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
		},
	},

	-- vim-cool (auto clear search highlight)
	{ 'romainl/vim-cool', event = "VeryLazy" },
}, {
	-- lazy.nvim options
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
