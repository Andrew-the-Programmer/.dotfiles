return {
  "neovim/nvim-lspconfig",
  lazy = false,
  -- enabled = false,
  opts = function(_, opts)
    opts.servers.basedpyright = require("functions").update({
      position_encoding = "utf-8",
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
          },
        },
      },
    }, opts.servers.basedpyright)
  end,
}
