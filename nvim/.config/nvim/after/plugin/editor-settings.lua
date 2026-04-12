local _border = "single"

vim.diagnostic.config({
	float = { border = _border },
	virtual_text = true,
})

-- Set the log level to "off" to disable logging
-- Set to "debug" when actually debugging
vim.lsp.log.set_level("off")

vim.o.winborder = "rounded"
