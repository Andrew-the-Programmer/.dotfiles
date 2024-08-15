-- Autocommand Group for Terminal and Directory Change
vim.api.nvim_create_augroup('TerminalChdir', { clear = true })

-- Autocommand to capture DirChanged event
vim.api.nvim_create_autocmd('DirChanged', {
    group = 'TerminalChdir',
    callback = function()
        -- Replace this print statement with your desired functionality.
        print("Directory changed to: " .. vim.fn.getcwd())
    end
})

-- Optional: If you want to restrict it only to terminal buffers
vim.api.nvim_create_autocmd('DirChanged', {
    group = 'TerminalChdir',
    callback = function()
        if vim.bo.buftype == 'terminal' then
            print("Terminal directory changed to: " .. vim.fn.getcwd())
        end
    end,
})
