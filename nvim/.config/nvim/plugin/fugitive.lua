-- We need a cross platform :Browse function
-- so :GBrowse in fugitive works properly
vim.api.nvim_create_user_command("Browse", require("browse").open, { nargs = 1 })
