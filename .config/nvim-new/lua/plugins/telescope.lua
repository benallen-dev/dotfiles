return	{
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
	opts = {
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case"
			}
		}
	},
	config = function(_, opts)
        require('telescope').setup(opts)
        require('telescope').load_extension('fzf')
    end,
	keys = {
		{
			"<leader>f",
			function() 
				require('telescope.builtin').find_files({ 
					find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }
				})
			end,
			 { desc = "Telescope find files" }
		}
	}
}
