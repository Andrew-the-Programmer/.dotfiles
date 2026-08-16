return {
  -- https://github.com/folke/zen-mode.nvim
  "folke/zen-mode.nvim",
  opts = {
    window = {
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = "0", -- disable fold column
        list = false, -- disable whitespace characters
      },
    },
    on_open = function(win)
      vim.g.zen_mode_old_virtual_text = vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = false })
    end,
    on_close = function()
      if vim.g.zen_mode_old_virtual_text ~= nil then
        vim.diagnostic.config({ virtual_text = vim.g.zen_mode_old_virtual_text })
        vim.g.zen_mode_old_virtual_text = nil
      end
    end,
  },
}
