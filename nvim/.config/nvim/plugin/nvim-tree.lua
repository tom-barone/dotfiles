-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable <C-e> so we can scroll normally
require("nvim-tree").setup({
	remove_keymaps = { "<C-e>" },
})
