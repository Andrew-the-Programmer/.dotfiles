return {
  "folke/snacks.nvim",
  lazy = false,
  opts = function(_, opts)
    opts.terminal = {
      win = {
        position = "float",
        border = "rounded",
      },
    }
  end,
}
