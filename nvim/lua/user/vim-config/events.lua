-- load language specific configs
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function(args)
        local buf = args.buf
        local bo = vim.bo
        local bo_buf = bo[buf]
        local ft = bo_buf.filetype
        -- print("args.buf: " .. Dump(buf))
        -- print("vim.bo: " .. Dump(bo))
        -- print("bo_buf: " .. Dump(bo_buf))
        -- print("filetype: " .. Dump(ft))

        local file = "user.language_specific." .. ft
        pcall(require, file)
    end,
})

-- vim.api.nvim_create_augroup("MyBufferEvents", { clear = true })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = "MyBufferEvents",
--     pattern = "*",
--     callback = function()
--         Notify("Hello")
--         print("Buffer modified!")
--     end,
-- })
