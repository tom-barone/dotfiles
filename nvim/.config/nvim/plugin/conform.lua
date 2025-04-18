require("conform").setup({
	formatters_by_ft = {
		python = { "tidy_imports", "ruff_fix", "ruff_format", "ruff_organize_imports" },
		javascript = { "prettier" },
		svelte = { "prettier" },
		typescript = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		xml = { "prettier" },
		eruby = { "erb_format", "erb_lint" },
		["eruby.yaml"] = { "prettier" },
		ruby = { "rubocop_fix" },
		just = { "just" },
		lua = { "stylua" },
		dart = { "dart_format" },
	},
})

-- Create a command to format the current buffer
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- Python
require("conform").setup({
	formatters = {
		tidy_imports = {
			-- Change where to find the command
			command = "tidy-imports",
			args = { "--quiet" },
		},
		erb_lint = {
			command = "erb_lint",
			args = { "--fail-level", "F", "--autocorrect", "$FILENAME" },
			stdin = false,
		},
		erb_format = {
			command = "erb-format",
		},
		rubocop_fix = {
			command = "rubocop",
			args = { "--autocorrect-all", "--stdin", "$FILENAME", "--stderr", "--fail-level", "F" },
			stdin = true,
		},
	},
})
