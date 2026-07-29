return {
  "neovim/nvim-lspconfig",
  lazy=false,
  opts = function(_, opts)
    local servers =
      { "pyright", "basedpyright", "ruff", "ruff_lsp", vim.g.lazyvim_python_lsp, vim.g.lazyvim_python_ruff }
    print(vim.g.lazyvim_python_lsp)
    for _, server in ipairs(servers) do
      opts.servers[server] = opts.servers[server] or {}
      opts.servers[server].enabled = server == vim.g.lazyvim_python_lsp or server == vim.g.lazyvim_python_ruff
    end
  end,
}
