https://github.com/akinsho/toggleterm.nvim/issues/608

Toggleterm don't open terminals correctly with inheritance.  When ChildTerm is opened with `ChildTerm:open()`, toggleterm opens terminal with count of it's parent (ParentTerm), which is 20. Though opened terminal's fields are correct, like `count`, `display_name` etc.

Toggleterm opens ChildTerm with the correct count of 40.

1. init.lua:
```lua
-- Load toggleterm with any plugin manager
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

-- Set optional keymaps to enter normal mode and print terminal count
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

-- This sets ParentTerm as `parent class` for ChildTerm
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

-- Set optional keymaps to open both terminals
vim.keymap.set("n", "<leader>t1", function()
    ParentTerm:open()
end, { desc = "Open terminal 1" })

vim.keymap.set("n", "<leader>t2", function()
    ChildTerm:open()
end, { desc = "Open terminal 2" })
```

2. Open ParentTerm with `:lua ParentTerm:open()` or `<leader>t1`.
3. Confirm that opened terminal count is 20 with `print(vim.api.nvim_buf_get_name(0))` or `<C-y>`.
4. Open ChildTerm with `:lua ChildTerm:open()` or `<leader>t2`.
5. Confirm that opened terminal count is 20 with `print(vim.api.nvim_buf_get_name(0))` or `<C-y>`.

- OS: Linux Mint 21.2 (Victoria)
- neovim version: 0.11.0-dev
- Shell: zsh

Sorry if it was stupid or wrong in some ways. It's literally my first issue.
I tried to figure this out myself, but I just couldn't.
Maybe it's lua-issue, I'm not very familiar with it, but I believe that the inheritance part actually works.
I'm not sure what's the difference between id and count is, so I set both.
Note that if ChildTerm is opened first, it's count will be 30. If you then open ParentTerm, it's count will be 20.
Really strange.
Feel free to delete this issue if you don't like it for some reason, I know you're a busy person.
Thank you very much 🥰
