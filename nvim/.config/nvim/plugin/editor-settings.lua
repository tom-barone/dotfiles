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

-- Create browse function so :GBrowse in fugitive works properly
vim.api.nvim_create_user_command(
  'Browse',
  function (opts)
		if vim.fn.has('wsl') == 1 then
			vim.fn.system { 'wslview', opts.fargs[1] }
		elseif vim.fn.has('mac') == 1 then
			vim.fn.system { 'open', opts.fargs[1] }
		elseif vim.fn.has('linux') == 1 then
			vim.fn.system { 'xdg-open', opts.fargs[1] }
		end
  end,
  { nargs = 1 }
)
