return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- opts.formatters.pg_format = {}
      opts.formatters_by_ft["sql"] = { "pg_format" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft["sql"] = { "pg_format" }
    end,
  },
}
