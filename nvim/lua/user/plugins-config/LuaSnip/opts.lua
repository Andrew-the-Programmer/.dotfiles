return {
	keep_roots = true,
	link_roots = true,
	link_children = true,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",

	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",

	-- luasnip uses this function to get the currently active filetype. This
	-- is the (rather uninteresting) default, but it's possible to use
	-- eg. treesitter for getting the current filetype by setting ft_func to
	-- require("luasnip.extras.filetype_functions").from_cursor (requires
	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
	ft_func = function()
		local ft = require("luasnip.extras.filetype_functions").from_cursor_pos()
		-- My.nvim.Notify(My.lua.Dump(ft))
		return ft
	end,
}
