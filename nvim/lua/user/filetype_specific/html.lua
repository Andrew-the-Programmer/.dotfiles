local utils = require("map_utils")
local lua_fn = utils.lua_fn

local opts = {}

local keymaps = {
	["<localleader>s"] = {
		mode = "v",
		rhs = function()
			local from, to = My.nvim.GetVisualSelection()
			local text = My.nvim.GetText(from, to)
			vim.ui.input({ prompt = "Tag and args: " }, function(input)
				print(input)
				local tag, args = string.match(input, "([a-z]+)(.*)")
				args = My.lua.IfNil(args, "")
				print(tag, args)
				local prefix = ("<%s%s>"):format(tag, args)
				local suffix = ("</%s>"):format(tag)
				local new_text = prefix .. text .. suffix
				My.nvim.SubstituteText(new_text, from, to)
			end)
		end,
		opts = { desc = "Itemize" },
	},
}

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.html",
	callback = function(ev)
		vim.opt.wrap = true

		for k, v in pairs(opts) do
			vim.api.nvim_buf_set_var(ev.buf, k, v)
		end
		for k, v in pairs(keymaps) do
			vim.api.nvim_buf_set_keymap(ev.buf, v.mode, k, lua_fn(v.rhs), v.opts)
		end
	end,
})
