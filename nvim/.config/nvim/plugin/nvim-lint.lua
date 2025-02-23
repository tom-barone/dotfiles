require("lint").linters_by_ft = {
	typescript = { "eslint" },
	eruby = { "erb_lint" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
