require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true, -- copilot.vim suggests as you type; copilot.lua defaults this to false
		keymap = {
			accept = "<C-d>", -- was copilot#Accept("\<CR>")
			accept_line = "<C-s>", -- was <Plug>(copilot-accept-line)
			accept_word = false,
			next = "<C-j>", -- was <Plug>(copilot-next)
			prev = "<C-k>", -- was <Plug>(copilot-previous)
			dismiss = "<C-]>",
		},
	},
	filetypes = {
		xml = false,
		markdown = true,
		dotenv = false,
	},
})

-- :Copilot disable / :Copilot enable exist in copilot.lua too, so these carry over as-is
vim.keymap.set("n", "<leader>cd", "<Cmd>Copilot disable<CR>")
vim.keymap.set("n", "<leader>ce", "<Cmd>Copilot enable<CR>")

-- Ghost text color (was: highlight CopilotSuggestion guifg=#555555 ctermfg=8)
vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", ctermfg = 8 })
