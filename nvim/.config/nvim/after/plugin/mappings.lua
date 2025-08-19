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
vim.keymap.set("v", "gx", require("browse").search_visual_selection)

-- Leader mappings
vim.keymap.set("n", "<Leader>Q", ":qa!")
vim.keymap.set("n", "<Leader>v", "<Cmd>source $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>V", ":tabedit $MYVIMRC")
vim.keymap.set("n", "<Leader>s", ":w<CR>")
vim.keymap.set("n", "<Leader>/", ":Cheat40<CR>")
vim.keymap.set("n", "<Leader>mp", "<Cmd>MarkdownPreview<CR>")
vim.keymap.set("n", "<Leader>fc", "<Cmd>let @+ = expand('%')<CR>")

-- Mappings for plugins
vim.keymap.set("n", "<Leader>tt", "<Cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>tf", "<Cmd>NvimTreeFindFile!<CR>")
vim.keymap.set("n", "<Leader>pc", "<Cmd>source $MYVIMRC | PlugClean<CR>")
vim.keymap.set("n", "<Leader>pi", "<Cmd>source $MYVIMRC | PlugInstall<CR>")
vim.keymap.set("n", "<Leader>pr", "<Cmd>Format<CR>")
vim.keymap.set("n", "<Leader>gy", "<Cmd>Goyo<CR>")

-- Fzf.vim
vim.keymap.set("n", "<C-t>", "<Cmd>Files<CR>")
vim.keymap.set("n", "<C-g><C-f>", "<Cmd>GFiles?<CR>")

vim.keymap.set("n", "<C-g><C-b>", "<Cmd>Buffers<CR>")
--vim.keymap.set("n", "<leader>ge", "<Cmd>Trouble diagnostics focus=false filter.buf=0<cr>")
--vim.keymap.set("n", "<leader>gE", "<Cmd>Trouble diagnostics<cr>")
--vim.keymap.set("n", "<leader>gr", "<Cmd>Trouble lsp_references<cr>")

-- Git commands
vim.keymap.set("n", "<leader>gh", "<Cmd>0Gclog<cr>")
vim.keymap.set("v", "<leader>gh", ":Gclog<cr>")
vim.keymap.set("n", "<leader>gq", "<Cmd>Gedit<CR>") -- Leave fugitive history explorer
vim.keymap.set("n", "<leader>gst", "<Cmd>Git<CR>")
vim.keymap.set("n", "<leader>gd", "<Cmd>Gvdiffsplit<CR>")
vim.keymap.set("n", "<leader>gl", "<Cmd>Gllog<CR>")

-- Diagnostic navigation
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)

-- LSP mappings
local fzf = require("fzf-lua")
fzf.register_ui_select() -- Required for LSP code actions
vim.keymap.set("n", "<Leader>lD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<Leader>ld", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>li", vim.lsp.buf.implementation)
--vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts) -- the signature help is already shown by the blink plugin
vim.keymap.set("n", "<Leader>lt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<Leader>ln", vim.lsp.buf.rename)
-- For displaying fzf-lua in a horizontal split
local h_opts = { winopts = { preview = { vertical = "up:40%", layout = "vertical" } } }
vim.keymap.set("n", "<Leader>la", function()
	fzf.lsp_code_actions(h_opts)
end)
vim.keymap.set("n", "<Leader>lr", function()
	fzf.lsp_references(h_opts)
end)
vim.keymap.set("n", "<Leader>le", function()
	fzf.lsp_document_diagnostics(h_opts)
end)
vim.keymap.set("n", "<Leader>lE", function()
	fzf.lsp_workspace_diagnostics(h_opts)
end)

-- Copilot mappings
vim.keymap.set("i", "<C-s>", "<Plug>(copilot-accept-line)")
vim.keymap.set("i", "<C-d>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
-- Disable default tab mapping
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
vim.keymap.set("n", "<leader>cd", "<Cmd>Copilot disable<CR>")
vim.keymap.set("n", "<leader>ce", "<Cmd>Copilot enable<CR>")
