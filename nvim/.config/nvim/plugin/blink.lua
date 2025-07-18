require("blink.cmp").setup({
	-- https://cmp.saghen.dev/configuration/keymap.html
	keymap = {
		preset = "none",
		["<Tab>"] = { "insert_next", "fallback" },
		["<S-Tab>"] = { "insert_prev", "fallback" },
		["<CR>"] = { "select_and_accept", "fallback" },
		["<C-n>"] = { "scroll_documentation_down", "snippet_forward", "fallback" },
		["<C-p>"] = { "scroll_documentation_up", "snippet_backward", "fallback" },
	},
	-- https://cmp.saghen.dev/configuration/keymap.html
	completion = {
		list = {
			selection = { preselect = false, auto_insert = true },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
		},
	},
	signature = {
		enabled = true,
	},
})
