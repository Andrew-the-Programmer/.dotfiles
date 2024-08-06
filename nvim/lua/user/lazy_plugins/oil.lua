return {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
        return require("user.plugins-config.oil.config")
    end,
}
