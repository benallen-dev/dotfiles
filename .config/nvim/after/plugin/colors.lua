local hostname = vim.uv.os_gethostname()

if hostname == "devbox" then
	require("catppuccin").setup({
		flavour = "auto", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = true, -- disables setting the background color.
		float = {
			transparent = false,   -- enable transparent floating windows
			solid = false,         -- use solid styling for floating windows, see |winborder|
		},
		show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
		term_colors = false,       -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false,       -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15,     -- percentage of the shade to apply to the inactive window
		},
		no_italic = false,         -- Force no italic
		no_bold = false,           -- Force no bold
		no_underline = false,      -- Force no underline
		styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
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
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
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
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})

	-- setup must be called before loading
	vim.cmd.colorscheme "catppuccin"
else
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
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "soft", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = true,
	})

	vim.cmd("colorscheme gruvbox")
end
