local map = vim.keymap.set

--Navigation-------------------------------------------------------------------

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the center when scrolling
-- map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Navigate vim panes better
-- See vim-tmux-navigator plugin
-- map({ "n" }, "<c-k>", "<cmd>wincmd k<CR>", { desc = "Navigate window up" })
-- map({ "n" }, "<c-j>", "<cmd>wincmd j<CR>", { desc = "Navigate window down" })
-- map({ "n" }, "<c-h>", "<cmd>wincmd h<CR>", { desc = "Navigate window left" })
-- map({ "n" }, "<c-l>", "<cmd>wincmd l<CR>", { desc = "Navigate window right" })

-- Navigate windows in terminal mode
-- Messes up my zsh config 😢
-- map({ "t" }, "<c-k>", "<cmd>wincmd k<CR>", { desc = "Navigate window up" })
-- map({ "t" }, "<c-j>", "<cmd>wincmd j<CR>", { desc = "Navigate window down" })
-- map({ "t" }, "<c-h>", "<cmd>wincmd h<CR>", { desc = "Navigate window left" })
-- map({ "t" }, "<c-l>", "<cmd>wincmd l<CR>", { desc = "Navigate window right" })

-- Vim: "L": move to bottom of screen
map({ "n", "v" }, "L", "$", { desc = "Jump to end of line" })

-- Vim: "H": move to top of screen
map({ "n", "v" }, "H", "^", { desc = "Jump to start of line" })

-- Vim: 'J': join line below to the current one with one space in between
map({ "n" }, "J", "G", { desc = "Jump to the end" })

-- Vim: 'K': open man page for word under the cursor
-- See lsp config
map({ "n" }, "K", "gg", { desc = "Jump to the start" })

--Clipboard--------------------------------------------------------------------

-- Copy selection to clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })

-- Paste from clipboard
map({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from clipboard" })
map("n", "<leader>P", [["+P]], { desc = "Paste line from clipboard" })

--Buffer-----------------------------------------------------------------------
map("n", "<leader>bx", My.nvim.MakeBufExecutable, { desc = "Make buffer file executable", silent = true })
map("n", "<leader>bv", "ggVG", { desc = "Select entire buffer to clipboard" })
map("n", "<leader>by", "<cmd>%y+<CR>", { desc = "Copy entire buffer to clipboard" })
map("n", "<leader>bp", 'ggVG"+p', { desc = "Paste entire buffer to clipboard" })

map("n", "<leader>w", "<cmd>w<cr>", { silent = false, desc = "Save buffer" })
map("n", "<leader>q", "<cmd>q<cr>", { silent = false, desc = "Quit window" })

-- Vim: "U": restore (undo) last changed line
map("n", "U", "<C-r>", { desc = "Redo" })

-- I have configured zsh to have vim mode, which I can enter with <esc> or <C-["
-- When in terminal zsh, I cant exit to normal mode.
-- See toggleterm config
-- map("t", "<C-{", "<esc>", { desc = "Escape terminal mode" })

map("n", "<C-м>", "<C-v>", { desc = "Redo" })

