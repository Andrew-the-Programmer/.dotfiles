vim.keymap.set("i", "<C-f>", function()
    local fig_name = vim.api.nvim_get_current_line()
    local fig_dir = "figures"
    local root = vim.b.vimtex.root
    local dir = root .. "/" .. fig_dir .. "/"
    local cmd = "silent exec .!inkscape-figures create"
    local args = { fig_name, dir }
    vim.cmd("silent exec '.!inkscape-figures create \"" .. fig_name .. "\" \"" .. dir .. "\"'")
    vim.cmd("w")
end)

vim.keymap.set("n", "<C-f>", function()
    local fig_name = vim.api.nvim_get_current_line()
    local fig_dir = "figures"
    local root = vim.b.vimtex.root
    local dir = root .. "/" .. fig_dir .. "/"
    local cmd = "silent exec \'.!inkscape-figures edit \"" .. dir .. "\" > /dev/null 2>&1 &\'"
    local args = {}
    vim.cmd({cmd=cmd, args=args})
    vim.cmd("redraw!")
end)

-- inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
-- nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
