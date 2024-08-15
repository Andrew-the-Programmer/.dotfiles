local New = vim.keymap.set

New({ "n", "t" }, "<localleader>oc", function()
    MyOil.CdToTermCwd()
end, { desc = "Open oil in terminal cwd" })
