function My.toggleterm.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-y>", function()
        local mttf = My.toggleterm.functions
        mttf.CloseTerm(mttf.GetTermByBufnr())
        -- mttf.Unfocuse()
        -- print(My.oil.term.OilTerm.id)
    end, { desc = "Unfocuse terminal" })
    vim.keymap.set("t", "<C-n>", function()
        local mttf = My.toggleterm.functions
        mttf.EnterNormalModeInTerm(mttf.GetTermByBufnr())
    end, { desc = "Unfocuse terminal" })
end

-- vim.keymap.set({ "t", "n" }, "<F1>", "<cmd>ToggleTerm<CR>")

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua My.toggleterm.set_terminal_keymaps()")
