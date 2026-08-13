return {
  "snacks.nvim",
  dependencies = { "obsidian.nvim", "oil.nvim" },
  opts = function(_, opts)
    table.insert(opts.dashboard.preset.keys, 1, {
      icon = "💡",
      key = "d",
      desc = "Do Ideas",
      action = function()
        vim.cmd("cd ~/tmp/Ideas")
        -- require("lazy").load({ plugins = { "obsidian.nvim" } })
        -- require("lazy").load({ plugins = { "oil.nvim" } })
        require("oil").open("~/tmp/Ideas/ideas")
      end,
    })
  end,
}
