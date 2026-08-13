return {
  "neovim/nvim-lspconfig",
  lazy = false,
  -- enabled = false,
  opts = function(_, opts)
    opts.servers.ruff = require("functions").update({
      position_encoding = "utf-8",
      settings = {
        lint = { enabled = false },
        -- diagnosticMode = "off",
      },
    }, opts.servers.ruff)
  end,
}
