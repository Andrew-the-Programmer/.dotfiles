function _G.StartOil()
	vim.cmd("Oil")
	vim.cmd("vsplit")
end

vim.api.nvim_create_user_command("StartOil", StartOil, { nargs = 0, desc = "Start oil file manager" })
