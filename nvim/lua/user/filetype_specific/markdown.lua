local utils = require("map_utils")
local lua_fn = utils.lua_fn

local opts = {}

local keymaps = {
	["<localleader>me"] = {
		mode = "n",
		rhs = function()
			local n = vim.fn.input("Number of lines: ")
			local row, _ = My.nvim.GetCursorPos():unpack()
			for i = 0, n - 1 do
				local cur_row = row + i
				My.nvim.PrependText(i + 1 .. ". ", { line_number = cur_row })
			end
		end,
		opts = { desc = "Enumerate" },
	},
	["<localleader>mi"] = {
		mode = "n",
		rhs = function()
			local n = vim.fn.input("Number of lines: ")
			local row, _ = My.nvim.GetCursorPos():unpack()
			for i = 0, n - 1 do
				local cur_row = row + i
				My.nvim.PrependText("- ", { line_number = cur_row })
			end
		end,
		opts = { desc = "Itemize" },
	},
	["<localleader>mh"] = {
		mode = "n",
		rhs = function()
			local line = My.nvim.GetLine()
			if not line:match("^#.*") then
				My.nvim.PrependText("# ")
				return
			end
			My.nvim.PrependText("#")
		end,
		opts = { desc = "Header" },
	},
	["<localleader>ma"] = {
		mode = "v",
		rhs = function()
			local visual_selection = My.nvim.get_visual_selection_text()
			if not visual_selection then
				return
			end
			local vs_text = table.concat(visual_selection, "\n")
			My.nvim.SubstituteVisualSelection(([[<abbr title=>%s</abbr>]]):format(vs_text))
			My.nvim.EnterNormalMode()
		end,
		opts = { desc = "Abbreviation" },
	},
	["<localleader>mu"] = {
		mode = "v",
		rhs = function()
			local visual_selection = My.nvim.get_visual_selection_text()
			if not visual_selection then
				return
			end
			local vs_text = table.concat(visual_selection, "\n")
			My.nvim.SubstituteVisualSelection(([[***%s***]]):format(vs_text))
			My.nvim.EnterNormalMode()
		end,
		opts = { desc = "Abbreviation" },
	},
}

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.md",
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
