function _G.StartOil()
    vim.cmd("Oil")
    vim.cmd("vsplit")
end

vim.api.nvim_create_user_command("StartOil", ":lua StartOil()<CR>", { nargs = 0, desc = "Start oil file manager" })
