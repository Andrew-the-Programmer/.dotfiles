local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
    spec = { { "akinsho/toggleterm.nvim" } },
})

function set_terminal_keymaps()
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
    vim.keymap.set("t", "<C-y>", function()
        print(vim.api.nvim_buf_get_name(0))
    end, { desc = "Print buffer name", buffer = 0 })
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

ParentTerm = Terminal:new({
    display_name = "ParentTerm",
    id = 10,
    count = 20,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function ParentTerm:new(opts)
    opts = opts or {}
    setmetatable(opts, { __index = self })
    return opts
end

ChildTerm = ParentTerm:new({
    display_name = "ChildTerm",
    id = 30,
    count = 40,
})

ChildTerm:open()
ChildTerm:close()

vim.keymap.set("n", "<leader>t1", function()
    ParentTerm:open()
end, { desc = "Open terminal 1" })

vim.keymap.set("n", "<leader>t2", function()
    ChildTerm:open()
end, { desc = "Open terminal 2" })
