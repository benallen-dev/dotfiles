-- https://ericlathrop.com/2024/02/configuring-neovim-s-lsp-to-work-with-godot/

-- Godot / GDScript
require('lspconfig').gdscript.setup{}

-- Listening server
local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end
