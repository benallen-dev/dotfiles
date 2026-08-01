print("Hello from plugins.harpoon")
local gh = require("utils").gh

-- Check if plenary is available, abort and show error otherwise
local ok, _ = pcall(require, "plenary.path")
if not ok then
	print("Plenary not available, skipping harpoon setup")
  return
end

-- Harpoon for quick shortcuts
-- Implicitly depends on plenary.path, so plenary needs to be installed first
vim.pack.add({ gh("theprimeagen/harpoon") })

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end)
