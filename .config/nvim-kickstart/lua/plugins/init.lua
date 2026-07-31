-- This code was adapted from kickstart.nvim to not use the 'custom' dir.
-- https://github.com/nvim-lua/kickstart.nvim/blob/b01d0527708d01b01c9f490dd6ad76d4f3166d0b/lua/custom/plugins/init.lua

local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('plugins.' .. module)
  end
end
