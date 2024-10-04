local mtt = My.toggleterm

vim.keymap.set("t", "<C-s>", function()
    local term = mtt.functions.GetTermByBufnr()
    mtt.functions.SaveTermCwd(term)
end, { desc = "Open oil in terminal cwd" })

vim.keymap.set("t", "<C-o>", function()
    My.oil.functions.OpenOilInTermCwd()
end, { desc = "Open oil in terminal cwd" })
