local mt = My.term

vim.keymap.set("n", "<leader>tt", function()
    My.term.FloatTerm:Open()
end, { desc = "Open float terminal" })

vim.keymap.set(
    { "n" },
    "<leader>te",
    mt.ExecuteBuffer,
    { desc = "Execute current buffer's file", noremap = true, silent = true }
)

