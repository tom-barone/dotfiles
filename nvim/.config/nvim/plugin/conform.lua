require("conform").setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		["eruby.yaml"] = { "prettier" },
		dart = { "dart_format" },
		dockerfile = { "dockerfmt" },
		eruby = { "erb_format", "erb_lint" },
		html = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier" },
		just = { "just" },
		lua = { "stylua" },
		markdown = { "prettier_markdown" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		r = { "air" },
		ruby = { "rubocop_fix" },
		sh = { "shfmt" },
		sql = { "sqlfluff" },
		svelte = { "prettier" },
		terraform = { "terraform_fmt" },
		toml = { "taplo" },
		typescript = { "prettier" },
		xml = { "prettier" },
		yaml = { "prettier" },
	},
})

-- Add args to the prettier formatter for markdown files
local markdown_formatter = vim.deepcopy(require("conform.formatters.prettier"))
require("conform.util").add_formatter_args(markdown_formatter, {
	"--prose-wrap",
	"never",
	"--ignore-path",
	"empty",
}, { append = false })
require("conform").formatters.prettier_markdown = markdown_formatter

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
		sqlfluff = {
			command = "uvx",
			inherit = false,
			args = {
				"sqlfluff",
				"format",
				"--dialect",
				"postgres",
				"-",
			},
			stdin = true,
		},
	},
})
