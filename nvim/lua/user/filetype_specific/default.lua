vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function(ev)
		-- my_opt = "any"
		-- tabs & indentation
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4

		My.opts.format_on_save = false
		vim.opt.wrap = false
	end,
})

-- My.Notify("Default settings loaded")
