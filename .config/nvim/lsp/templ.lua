---@type vim.lsp.Config
return {
  cmd = { 'templ', 'lsp' },
  filetypes = { 'templ' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { 'go.mod', '.git' })
    if root then
      on_dir(root)
    end
  end,
}
