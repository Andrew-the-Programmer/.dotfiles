local mo = My.oil

-- vim.keymap.set("t", "<C-s>", function()
--     local term = mtt.functions.GetTermByBufnr()
--     mtt.functions.SaveTermCwd(term)
-- end, { desc = "Open oil in terminal cwd" })

vim.keymap.set("t", "<C-o>", function()
	mo.term.OilTerm:OpenOil()
end, { desc = "Open oil in terminal cwd" })
