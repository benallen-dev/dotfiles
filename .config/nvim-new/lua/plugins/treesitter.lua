return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
	indent = { enable = true },
	highlight = { enable = true },
	folds = { enabled = true },
  }
}
