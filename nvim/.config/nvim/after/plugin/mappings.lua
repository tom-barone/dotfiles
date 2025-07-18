-- Basic remaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-e>", "3<C-e>")
vim.keymap.set("n", "<C-y>", "3<C-y>")
vim.keymap.set("n", "<C-X>", ":Bdelete<CR>")
vim.keymap.set("l", "<C-c>", "<C-[>") -- For command line modes
vim.keymap.set("n", "<C-Q>", ":q<CR>")

-- Leader mappings
vim.keymap.set("n", "<Leader>Q", ":qa!")
vim.keymap.set("n", "<Leader>v", "<Cmd>source $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>V", ":tabedit $MYVIMRC")
vim.keymap.set("n", "<Leader>s", ":w<CR>")

-- Mappings for plugins
vim.keymap.set("n", "<Leader>tt", "<Cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>tf", "<Cmd>NvimTreeFindFile!<CR>")
vim.keymap.set("n", "<Leader>pc", "<Cmd>source $MYVIMRC | PlugClean<CR>")
vim.keymap.set("n", "<Leader>pi", "<Cmd>source $MYVIMRC | PlugInstall<CR>")
vim.keymap.set("n", "<Leader>pr", "<Cmd>Format<CR>")
vim.keymap.set("n", "<Leader>gy", "<Cmd>Goyo<CR>")

-- Fzf.vim
vim.keymap.set("n", "<C-y>", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<C-t>", "<Cmd>Files<CR>")
vim.keymap.set("n", "<C-g><C-f>", "<Cmd>FzfLua git_status<CR>")

vim.keymap.set("n", "<C-g><C-b>", "<Cmd>Buffers<CR>")
vim.keymap.set("n", "<leader>ge", "<Cmd>Trouble diagnostics focus=false filter.buf=0<cr>")
vim.keymap.set("n", "<leader>gE", "<Cmd>Trouble diagnostics<cr>")
vim.keymap.set("n", "<leader>gr", "<Cmd>Trouble lsp_references<cr>")

-- Git commands
vim.keymap.set("n", "<leader>gh", "<Cmd>0Gclog<cr>")
vim.keymap.set("v", "<leader>gh", ":Gclog<cr>")
vim.keymap.set("n", "<leader>gq", "<Cmd>Gedit<CR>") -- Leave fugitive history explorer
vim.keymap.set("n", "<leader>gst", "<Cmd>Git<CR>")

-- Diagnostic navigation
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end)

-- Copilot mappings
vim.keymap.set("i", "<C-s>", "<Plug>(copilot-accept-line)")
vim.keymap.set("i", "<C-d>", function()
	return vim.fn["copilot#Accept"]("<CR>")
end, { expr = true, silent = true })

-- Disable default tab mapping for copilot
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
vim.keymap.set("n", "<leader>cd", "<Cmd>Copilot disable<CR>")
vim.keymap.set("n", "<leader>ce", "<Cmd>Copilot enable<CR>")
