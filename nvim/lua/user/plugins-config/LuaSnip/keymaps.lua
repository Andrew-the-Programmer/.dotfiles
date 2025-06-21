local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "hh", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { desc = "LuaSnip: next choice" })

vim.keymap.set({ "i", "s" }, "jj", function()
	if ls.jumpable() then
		ls.jump(1)
	end
end, { silent = true, desc = "LuaSnip: Jump to next field" })

vim.keymap.set({ "i", "s" }, "kk", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true, desc = "LuaSnip: Jump to previous field" })

vim.keymap.set({ "i", "s" }, "ll", function()
	if ls.expandable() then
		ls.expand({})
	end
end, { silent = true, desc = "LuaSnip: Expand snippet" })
