return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "frappe",
            -- transparent_background = true,
        },
        config = function()
            -- vim.cmd.colorscheme("catppuccin-frappe")
        end,
    },
}
