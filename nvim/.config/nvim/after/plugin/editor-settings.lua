local _border = "single"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})
vim.diagnostic.config({
	float = { border = _border },
})

-- Set the log level to "off" to disable logging
-- Set to "debug" when actually debugging
vim.lsp.set_log_level("off")

vim.o.winborder = "rounded"

vim.diagnostic.config({ virtual_text = true })
