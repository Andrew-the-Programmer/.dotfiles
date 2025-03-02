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

	-- Specify how to handle attachments.
	attachments = {
		-- The default folder to place images in via `:ObsidianPasteImg`.
		-- If this is a relative path it will be interpreted as relative to the vault root.
		-- You can always override this per image by passing a full path to the command instead of just a filename.
		img_folder = "assets/imgs", -- This is the default

		confirm_img_paste = false,

		-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
		---@return string
		img_name_func = function()
			-- Prefix image names with timestamp.
			return string.format("%s", os.time())
		end,

		-- A function that determines the text to insert in the note when pasting an image.
		-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
		-- This is the default implementation.
		---@param client obsidian.Client
		---@param path obsidian.Path the absolute path to the image file
		---@return string
		img_text_func = function(client, path)
			path = client:vault_relative_path(path) or path
			return string.format("![[%s|%s]]", path.name, path)
		end,
	},
}
