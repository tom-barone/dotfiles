-- Don't log things by default, enable when debugging
vim.g.lsp_log_file = "~/downloads/test.log"
vim.g.lsp_log_verbose = 1

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<Leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>ga", "<cmd>CodeActionMenu<cr>")
end

-- Set up nvim-cmp.
local cmp = require("cmp")
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
    mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
    }),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Set up lspconfig.
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
  commands = {
    OrganiseImports = {
      function()
				local params = {
					command = "_typescript.organizeImports",
					arguments = {vim.api.nvim_buf_get_name(0)},
					title = ""
				}
				vim.lsp.buf.execute_command(params)
			end,
      description = "Organise Imports"
    }
  }
})
require("lspconfig").lua_ls.setup({ -- Lua
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},

			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
require("lspconfig").solargraph.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").vimls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/Users/tbone/.rustup/toolchains/stable-x86_64-apple-darwin/bin/rust-analyzer" },
})
require("lspconfig").bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require'lspconfig'.jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
require'lspconfig'.html.setup {
	on_attach = on_attach,
  capabilities = capabilities,
}
require'lspconfig'.cssls.setup {
	on_attach = on_attach,
  capabilities = capabilities,
}
