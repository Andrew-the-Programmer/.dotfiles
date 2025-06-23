return {
	keep_roots = true,
	link_roots = true,
	link_children = true,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",

	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",

	ft_func = function()
		local ft = require("luasnip.extras.filetype_functions").from_cursor_pos()
		ft = My.lua.ListExtend(ft, My.nvim.get_synstack())
		return ft
	end,
}
