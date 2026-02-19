vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.enable("ruby_lsp")
vim.lsp.config("ruby_lsp", {
	init_options = {
		addonSettings = {
			["Ruby LSP Rails"] = {
				enablePendingMigrationsPrompt = false,
			},
		},
	},
})
vim.lsp.enable("vimls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
				features = "all",
				allTargets = true,
			},
			cargo = {
				--target = "wasm32-unknown-unknown",
				features = "all",
				allTargets = true,
			},
		},
	},
})
vim.lsp.enable("bashls")
vim.lsp.enable("eslint")
vim.lsp.enable("jsonls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("gopls")
vim.lsp.enable("svelte")
vim.lsp.enable("dartls")
-- vim.lsp.enable("denols")
vim.lsp.enable("taplo")
