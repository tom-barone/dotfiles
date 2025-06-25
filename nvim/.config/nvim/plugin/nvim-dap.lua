local dap = require("dap")
--local dapui = require("dapui")
--dapui.setup()
dap.configurations.dart = {
	{
		type = "flutter",
		request = "attach",
		name = "Launch flutter",
		dartSdkPath = "~/flutter/bin/dart", -- ensure this is correct
		flutterSdkPath = "~/flutter/bin/flutter", -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
		cwd = "${workspaceFolder}",
	},
}
dap.adapters.flutter = {
	type = "executable",
	command = "flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
	args = { "debug_adapter" },
	-- windows users will need to set 'detached' to false
	--options = {
	--  detached = false,
	--},
}

vim.keymap.set("n", "<Leader>bc", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<Leader>bo", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<Leader>bi", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<Leader>bO", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>bb", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>bQ", function()
	require("dap").terminate()
end)
vim.keymap.set("n", "<Leader>bA", ":DapNew<CR>")
vim.keymap.set({ "n", "v" }, "<Leader>bh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>bp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>bf", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>bs", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)

--dap.listeners.before.attach.dapui_config = function()
--  dapui.open()
--end
--dap.listeners.before.launch.dapui_config = function()
--  dapui.open()
--end
--dap.listeners.before.event_terminated.dapui_config = function()
--  dapui.close()
--end
--dap.listeners.before.event_exited.dapui_config = function()
--  dapui.close()
--end
