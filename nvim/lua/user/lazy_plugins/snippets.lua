return {
    {
        -- https://github.com/SirVer/ultisnips
        "SirVer/ultisnips",
        config = function()
            -- vim.g.UltiSnipsExpandTrigger = "<C-y>"

            -- Somehow works: <C-j/k>, see cmp config
            -- vim.g.UltiSnipsJumpForwardTrigger = "<C-n>"
            -- vim.g.UltiSnipsJumpBackwardTrigger = "<C-p>"

            vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "UltiSnips-my", "UltiSnips-vsnip" }
        end,
        opts = {},
    },
    {
        -- https://github.com/L3MON4D3/LuaSnip
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            -- Load snippets from vscode
            -- require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        -- https://github.com/rafamadriz/friendly-snippets
        "rafamadriz/friendly-snippets",
    },
    {
        -- https://github.com/honza/vim-snippets?tab=readme-ov-file
        "honza/vim-snippets",
        lazy = true,
        config = function() end,
    },
}
