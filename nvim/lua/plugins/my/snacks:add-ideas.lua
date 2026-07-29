return {
  "snacks.nvim",
  dependencies = { "obsidian.nvim" },
  opts = function(_, opts)
    table.insert(opts.dashboard.preset.keys, 1, {
      icon = "💡",
      key = "i",
      desc = "New Idea",
      action = function()
        vim.cmd("cd ~/tmp/Ideas")
        vim.cmd("ObsidianNew")
      end,
    })
  end,
}
