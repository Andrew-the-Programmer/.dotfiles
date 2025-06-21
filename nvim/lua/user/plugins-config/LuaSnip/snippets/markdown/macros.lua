local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local l = require("luasnip.extras").lambda
local dl = require("luasnip.extras").dynamic_lambda

local M = {}

function M.major_block(name)
	return {
		t({ "# " .. name, "", "" }),
		i(0),
	}
end

function M.sub_block(name)
	return {
		t({ "## " .. name .. ":", "", "" }),
		i(0),
	}
end

ls.add_snippets("markdown", {
	s({
		trig = "mi",
		desc = "inline math",
	}, {
		t("$"),
		i(0),
		t("$"),
	}),
	s({
		trig = "mb",
		desc = "block math",
	}, {
		t({ "$$", "" }),
		i(0),
		t({ "", "$$" }),
	}),
	s({
		trig = "definition",
	}, M.major_block("Definition")),
	s({
		trig = "theorem",
	}, M.major_block("Theorem")),
	s({
		trig = "claim",
	}, M.major_block("Claim")),
	s({
		trig = "if",
	}, M.sub_block("If")),
	s({
		trig = "then",
	}, M.sub_block("Then")),
	s({
		trig = "proof",
	}, M.major_block("Proof")),
})
