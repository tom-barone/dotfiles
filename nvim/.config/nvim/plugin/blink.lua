require("blink.cmp").setup({
	-- https://cmp.saghen.dev/configuration/keymap.html
	keymap = {
		preset = "none",
		["<Tab>"] = {
			-- If completion is not visible, do a regular tab
			function(cmp)
				if cmp.is_menu_visible() then
					cmp.insert_next()
					return true
				end
			end,
			"fallback",
		},
		["<S-Tab>"] = {
			function(cmp)
				if cmp.is_menu_visible() then
					cmp.insert_prev()
					return true
				end
			end,
			"fallback",
		},
		["<CR>"] = { "select_and_accept", "fallback" },
		["<C-n>"] = { "scroll_documentation_down", "snippet_forward", "fallback" },
		["<C-p>"] = { "scroll_documentation_up", "snippet_backward", "fallback" },
		-- On macOS, <C-space> is reserved for switching input sources, so that needs to
		-- be disabled before using it here.
		["<C-Space>"] = {
			"show",
			"hide",
			"fallback",
		},
	},
	-- https://cmp.saghen.dev/configuration/reference.html
	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
		menu = {
			border = "rounded",
			auto_show = false,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
			window = {
				border = "rounded",
			},
		},
	},
	signature = {
		enabled = true,
	},
})
