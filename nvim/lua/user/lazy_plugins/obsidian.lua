return {
	-- https://github.com/epwalsh/obsidian.nvim
	"epwalsh/obsidian.nvim",
	version = "*", -- latest
	-- lazy = true,
	-- ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"preservim/vim-markdown",
	},
	config = function()
		require("user.plugins-config.obsidian")
	end,
}
