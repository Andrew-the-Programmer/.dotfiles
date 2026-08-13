return {
  "neovim/nvim-lspconfig",
  lazy = false,
  enabled = false,
  opts = function(_, opts)
    opts.servers.pyright = require("functions").update({
      position_encoding = "utf-8",
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            typeCheckingMode = "strict",
            extraPaths = {
              "/home/andrew/.conda/envs/shiro/lib/python3.14/site-packages",
            },
          },
        },
      },
    }, opts.servers.pyright)
  end,
}
