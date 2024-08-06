function _G.StartOil()
    vim.cmd("Oil")
    -- vim.bo.filetype = "oil"

    local buf

    buf = vim.api.nvim_get_current_buf()
    print(buf)

    vim.cmd("vsplit")

    buf = vim.api.nvim_get_current_buf()
    print(buf)
end

vim.api.nvim_create_user_command("StartOil", ":lua StartOil()<CR>", { nargs = 0, desc = "Start oil file manager" })
