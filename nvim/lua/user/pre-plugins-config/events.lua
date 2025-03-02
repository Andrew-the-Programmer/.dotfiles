-- Load language specific configs
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*" },
	desc = "Load filetype specific settings",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
        local parent = "user.filetype_specific."
		local file = parent .. ft

        -- Load default filetype settings
		My.lua.Require(parent .. "default")

		-- Try to load filetype settings
		pcall(My.lua.Require, file)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
	pattern = "help",
	desc = "Open help in vertical split",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Format on save",
	callback = function()
		if not My.opts.format_on_save then
			return
		end
		-- My.nvim.Notify("Formating buffer!")
		vim.lsp.buf.format({ async = false })
	end,
})
