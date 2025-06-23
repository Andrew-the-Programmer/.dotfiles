local Keymap = My.keymaps.Keymap

return {
	--Navigation-------------------------------------------------------------------

	-- Move lines in visual mode
	Keymap:new_nvim("v", "J", ":m '>+1<CR>gv=gv"),
	Keymap:new_nvim("v", "K", ":m '<-2<CR>gv=gv"),

	-- Keep cursor in the center when scrolling
	-- map("n", "J", "mzJ`z")
	Keymap:new_nvim("n", "<C-d>", "<C-d>zz"),
	Keymap:new_nvim("n", "<C-u>", "<C-u>zz"),
	Keymap:new_nvim("n", "n", "nzzzv"),
	Keymap:new_nvim("n", "N", "Nzzzv"),

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
	Keymap:new_nvim({ "n", "v" }, "L", "$", { desc = "Jump to end of line" }),

	-- Vim: "H": move to top of screen
	Keymap:new_nvim({ "n", "v" }, "H", "^", { desc = "Jump to start of line" }),

	-- Vim: 'J': join line below to the current one with one space in between
	Keymap:new_nvim({ "n" }, "J", "G", { desc = "Jump to the end" }),

	-- Vim: 'K': open man page for word under the cursor
	-- See lsp config
	Keymap:new_nvim({ "n" }, "K", "gg", { desc = "Jump to the start" }),

	--Clipboard--------------------------------------------------------------------

	-- Copy to clipboard
	Keymap:new_map({
		["<leader>y"] = { "n", "v" },
		["<C-с>"] = { "n", "i" },
	}, [["+y]], { desc = "Copy to clipboard" }),
	Keymap:new_nvim("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" }),

	-- Paste from clipboard
	Keymap:new_map({
		["<leader>p"] = { "n", "v" },
		["<C-м>"] = { "n", "i" },
	}, [["+p]], { desc = "Paste from clipboard" }),
	Keymap:new_nvim("n", "<leader>P", [["+P]], { desc = "Paste line from clipboard" }),

	--Buffer-----------------------------------------------------------------------
	Keymap:new_nvim(
		"n",
		"<leader>bx",
		My.nvim.MakeBufExecutable,
		{ desc = "Make buffer file executable", silent = true }
	),
	Keymap:new_nvim("n", "<leader>bv", "ggVG", { desc = "Select entire buffer to clipboard" }),
	Keymap:new_nvim("n", "<leader>by", "<cmd>%y+<CR>", { desc = "Copy entire buffer to clipboard" }),
	Keymap:new_nvim("n", "<leader>bp", 'ggVG"+p', { desc = "Paste entire buffer to clipboard" }),

	Keymap:new_nvim("n", "<leader>w", "<cmd>w<cr>", { silent = false, desc = "Save buffer" }),
	Keymap:new_nvim("n", "<leader>q", "<cmd>q<cr>", { silent = false, desc = "Quit window" }),

	-- Vim: "U": restore (undo) last changed line
	Keymap:new_nvim("n", "U", "<C-r>", { desc = "Redo" }),

	-- I have configured zsh to have vim mode, which I can enter with <esc> or <C-["
	-- When in terminal zsh, I cant exit to normal mode.
	-- See toggleterm config
	-- map("t", "<C-{", "<esc>", { desc = "Escape terminal mode" })

	Keymap:new_nvim("i", { "dd", "вв", "<C-х>" }, "<esc>", { desc = "Enter normal mode" }),

	Keymap:new_nvim("n", "<leader>tm", function()
        vim.cmd("Inspect")
	end, { desc = "Print syntax stack" }),
}
