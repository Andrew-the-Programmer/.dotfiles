return {
    -- https://github.com/Exafunction/codeium.nvim
    "Exafunction/codeium.vim",
    -- event = "BufEnter",
    config = function()
        vim.g.codeium_disable_bindings = 1
        vim.g.codeium_no_map_tab = 1
        -- vim.g.codeium_tab_fallback = '<C-g>'
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set("i", "<C-y>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true, desc = "Codeium Accept" })
        vim.keymap.set("i", "<C-n>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true, desc = "Codeium Cycle Completions forward" })
        vim.keymap.set("i", "<C-p>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true, desc = "Codeium Cycle Completions backward" })
        vim.keymap.set("i", "<C-x>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true, desc = "Codeium Clear" })
    end,
}
