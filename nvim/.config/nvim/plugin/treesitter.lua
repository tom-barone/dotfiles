require("nvim-treesitter").install({
	"all",
})

local disable = { ["eruby.yaml"] = true }

-- Enable treesitter for all filetypes, but don't throw an error if it fails
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		if disable[args.match] then
			vim.treesitter.stop(args.buf)
		else
			pcall(vim.treesitter.start, args.buf)
		end
	end,
})
