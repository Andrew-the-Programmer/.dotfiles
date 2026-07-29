return {
  "declancm/windex.nvim",
  config = function()
    require("windex").setup({ default_keymaps = false })
    vim.keymap.set("n", "<Leader>bm", function()
      require("windex").toggle_maximize()
    end)
  end,
}
