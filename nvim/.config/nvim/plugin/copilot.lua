-- use this table to disable/enable filetypes
vim.g.copilot_filetypes = { xml = false, markdown = true }

-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
-- vim.g.copilot_filetypes = { ["*"] = false, python = true }


-- make the suggestions appear
vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])
