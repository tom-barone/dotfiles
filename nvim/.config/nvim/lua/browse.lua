local M = {}

-- Create browse function so :GBrowse in fugitive works properly
vim.api.nvim_create_user_command("Browse", function(opts)
	if vim.fn.has("wsl") == 1 then
		vim.fn.system({ "wslview", opts.fargs[1] })
	elseif vim.fn.has("mac") == 1 then
		vim.fn.system({ "open", opts.fargs[1] })
	elseif vim.fn.has("linux") == 1 then
		vim.fn.system({ "xdg-open", opts.fargs[1] })
	end
end, { nargs = 1 })

-- URL encode function for proper search query formatting
local function url_encode(str)
	return str:gsub("([^%w%-%.%_~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
end

function M.open(opts)
	if vim.fn.has("wsl") == 1 then
		vim.fn.system({ "wslview", opts.fargs[1] })
	elseif vim.fn.has("mac") == 1 then
		vim.fn.system({ "open", opts.fargs[1] })
	elseif vim.fn.has("linux") == 1 then
		vim.fn.system({ "xdg-open", opts.fargs[1] })
	end
end

-- Search DuckDuckGo with visually selected text
function M.search_visual_selection()
	-- Get visually selected text by yanking to register 'x'
	vim.cmd('normal! "xy')
	local selected_text = vim.fn.getreg("x")

	-- Clean up the text (normalize whitespace and trim)
	selected_text = selected_text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

	-- Create DuckDuckGo search URL
	local encoded_text = url_encode(selected_text)
	local search_url = "https://duckduckgo.com/?q=" .. encoded_text

	-- Use existing Browse command
	vim.cmd("Browse " .. search_url)
end

return M
