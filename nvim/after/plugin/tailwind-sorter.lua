require('tailwind-sorter').setup({
  on_save_enabled = false,
  on_save_pattern = { '*.html', '*.js', '*.jsx', '*.tsx', '*.twig', '*.hbs', '*.php', '*.heex', '*.astro' }, -- The file patterns to watch and sort.
  node_path = 'node',
})

vim.keymap.set('n', '<leader>ts', ':TailwindSort<CR>')
