return {
	-- https://github.com/rmagatti/auto-session
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			auto_save_enabled = false,
			auto_restore_enabled = true,
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		})

		vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
			noremap = true,
		})
	end,
}
