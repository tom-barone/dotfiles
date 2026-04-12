require("nvim-treesitter").install({
	"all",
})

-- Enable treesitter for all filetypes, but don't throw an error if it fails
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
