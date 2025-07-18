-- We want to use our own cheat40.txt file in ../cheat40.txt
vim.g.cheat40_use_default = 0

-- Close the cheat window with the same keybinding as opening it
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cheat40",
	callback = function()
		vim.o.signcolumn = "no" -- hide sign column
		vim.keymap.set(
			"n",
			"<Leader>/",
			'<c-w><c-p>@=winnr("#")<cr><c-w>c', -- closes the cheat window
			{ noremap = true, silent = true, buffer = true }
		)
	end,
})
