local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
	s(
		"func",
		fmt(
			[[
        def {func}({args}):
        {t}{body}
        ]],
			{
				func = i(1),
				args = i(2),
				body = i(3),
				t = t("\t"),
			}
		)
	),
})
