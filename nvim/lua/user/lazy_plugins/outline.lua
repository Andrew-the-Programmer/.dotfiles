return {
	-- https://github.com/hedyhli/outline.nvim
	-- Symbols-outline plugin substitute
	"hedyhli/outline.nvim",
	config = function()
		require("outline").setup()
		vim.keymap.set("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle outline" })
	end,
}
