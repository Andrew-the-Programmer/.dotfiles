local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local m = require("luasnip.extras").match
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda

local sf = require("user.plugins-config.LuaSnip.snippets.latex.snip_funcs")

ls.add_snippets("latex", {
	sf.greek_letter("a", "alpha"),
	sf.greek_letter("b", "beta"),
	sf.greek_letter("g", "gamma"),
	sf.greek_letter("G", "Gamma"),
	sf.greek_letter("d", "delta"),
	sf.greek_letter("D", "Delta"),
	sf.greek_letter("e", "varepsilon"),
	sf.greek_letter("z", "zeta"),
	sf.greek_letter("h", "eta"), -- NOTE: bad naming
	sf.greek_letter("th", "theta"), -- NOTE: bad naming
	sf.greek_letter("Th", "Theta"), -- NOTE: bad naming
	sf.greek_letter("k", "kappa"),
	sf.greek_letter("l", "lambda"),
	sf.greek_letter("L", "Lambda"),
	sf.greek_letter("m", "mu"),
	sf.greek_letter("n", "nu"),
	sf.greek_letter("x", "xi"),
	sf.greek_letter("X", "Xi"),
	sf.greek_letter("p", "pi"),
	sf.greek_letter("P", "Pi"),
	sf.greek_letter("r", "rho"),
	sf.greek_letter("s", "sigma"),
	sf.greek_letter("S", "Sigma"),
	sf.greek_letter("t", "tau"),
	sf.greek_letter("u", "upsilon"),
	sf.greek_letter("U", "Upsilon"),
	sf.greek_letter("f", "varphi"), -- NOTE: bad naming
	sf.greek_letter("F", "Phi"), -- NOTE: bad naming
	sf.greek_letter("c", "chi"),
	sf.greek_letter("y", "psi"), -- NOTE: really bad naming
	sf.greek_letter("Y", "Psi"), -- NOTE: really bad naming
	sf.greek_letter("o", "omega"),
	sf.greek_letter("O", "Omega"),

	sf.keyword_simple("N", "NN"),
	sf.keyword_simple("Z", "ZZ"),
	sf.keyword_simple("Q", "QQ"),
	sf.keyword_simple("R", "RR"),
	sf.keyword_simple("Re", "RRe"),
	sf.keyword_simple("C", "CC"),
	sf.keyword_simple("PP", "PP"),
	sf.keyword_simple("HH", "HH"),
	sf.keyword_simple("FF", "FF"),

	sf.keyword_simple("inf", "infty"),

	sf.power("sr", "2"),
	sf.power("cb", "3"),

	sf.binary_operator_auto("--", "\\dash"),

	sf.unary_operator("d", "\\d"),
	sf.unary_operator("D", "\\D"),
	sf.unary_operator("L", "\\Laplace"),
	sf.unary_operator("DA", "\\DAlambert"),
	sf.unary_operator("N", "\\Nabla"),
	sf.unary_operator("G", "\\grad"),
	sf.unary_operator("not", "\\lnot"),

	sf.binary_operator("eq", "="),
	sf.binary_operator("ne", "\\neq"),
	sf.binary_operator_auto("!=", "\\neq"),
	sf.binary_operator("de", "\\defeq"),
	sf.binary_operator_auto(":=", "\\defeq"),
	sf.binary_operator("le", "\\le"),
	sf.binary_operator_auto("<=", "\\le"),
	sf.binary_operator("ge", "\\ge"),
	sf.binary_operator_auto(">=", "\\ge"),
	sf.binary_operator("ll", "\\ll"),
	sf.binary_operator_auto("<<", "\\ll"),
	sf.binary_operator("gg", "\\gg"),
	sf.binary_operator_auto(">>", "\\gg"),
	sf.binary_operator("im", "\\implies"),
	sf.binary_operator("imb", "\\impliedby"),
	sf.binary_operator_auto("->", "\\implies"),
	sf.binary_operator_auto("<-", "\\impliedby"),

	sf.binary_operator("un", "\\cup"),
	sf.binary_operator("ir", "\\cap"),
	sf.binary_operator("or", "\\lor"),
	sf.binary_operator("and", "\\land"),

	sf.binary_operator_auto("**", "\\times"),
	sf.binary_operator_auto("xx", "\\cdot"),

	sf.unary_func("circled", "circled"),
	sf.unary_func("ol", "overline"),
	sf.unary_func("ul", "underline"),
	sf.unary_func("wt", "widetilde"),
	sf.unary_func("wh", "widehat"),
	sf.unary_func("abs", "abs"),
	sf.unary_func("norm", "norm"),
	sf.unary_func("ceil", "ceil"),
	sf.unary_func("floor", "floor"),
	sf.unary_func("round", "round"),
	sf.unary_func("vec", "vec"),
	sf.unary_func("sur", "surround"),
	sf.unary_func("set", "set"),
	sf.unary_func("gr", "group"),
	sf.unary_func("grr", "groupr"),
	sf.unary_func("grt", "groupt"),
	sf.unary_func("tt", "text"),
	sf.unary_func("ti", "textit"),

	sf.env("gather", "Gather"),
	sf.env("cases", "Cases"),
	sf.env("array", "Array"),
	sf.env("matrix", "Matrix"),
	sf.env("alignleft", "AlignLeft"),
	sf.env("aligncenter", "AlignCenter"),
	sf.env("align", "Align"),

	sf.unary_func_with_index("exp", "exp"),
	sf.unary_func_with_index("ln", "ln"),
	sf.unary_func_with_index("log", "log"),
	sf.unary_func("sq", "sqrt"),

	sf.unary_func_with_index("sin", "sin"),
	sf.unary_func_with_index("cos", "cos"),
	sf.unary_func_with_index("tg", "tg"),
	sf.unary_func_with_index("ct", "ct"),
	sf.unary_func_with_index("asin", "arcsin"),
	sf.unary_func_with_index("acos", "arccos"),
	sf.unary_func_with_index("atg", "arctg"),
	sf.unary_func_with_index("act", "arcct"),
	sf.unary_func_with_index("sh", "sh"),
	sf.unary_func_with_index("ch", "ch"),

	-- dv, Dv, pdv, pDv, vdv, vDv
	s(
		{
			trig = "([pv]?[dD]v)(%d?)(%a?)(%a?)",
			trigEngine = "pattern",
		},
		fmta("\\<op><1>{<2>}{<3>}", {
			op = f(function(args, snip)
				return snip.captures[1]
			end),
			[1] = d(1, function(args, snip)
				local capture = snip.captures[2]
				if capture:len() > 0 then
					return sn(nil, { t("[" .. capture .. "]") })
				else
					return sn(nil, {})
				end
			end),
			[2] = d(2, function(args, snip)
				local capture = snip.captures[3]
				if capture:len() > 0 then
					return sn(nil, { t(capture) })
				else
					return sn(nil, { i(1) })
				end
			end),
			[3] = d(3, function(args, snip)
				local capture = snip.captures[4]
				if capture:len() > 0 then
					return sn(nil, { t(capture) })
				else
					return sn(nil, { i(1) })
				end
			end),
		})
	),
	-- veccross, vecprod
	s(
		{
			trig = "v([pc])",
			trigEngine = "pattern",
		},
		fmta("\\vec<op>{<>}{<>}", {
			op = f(function(args, snip)
				local capture = snip.captures[2]
				if capture == "p" then
					return "prod"
				else
					return "cross"
				end
			end),
			i(1),
			i(2),
		})
	),
	-- lim, limsup, liminf
	s({
		trig = "lim([is]?)",
		trigEngine = "pattern",
	}, {
		t("\\lim"),
		f(function(args, snip)
			local capture = snip.captures[1]
			if capture == "s" then
				return "sup"
			elseif capture == "i" then
				return "inf"
			else
				return ""
			end
		end),
		m(1, "^$", "", "_{"),
		c(1, {
			sn(nil, { i(1), t(" \\to "), i(2) }),
			sn(nil, { i(1) }),
		}),
		m(1, "^$", "", "}"),
		t("{"),
		i(2),
		t("}"),
	}, sf.dont_repeat("lim")),
	s(
		{
			trig = "lim([is]?)",
			trigEngine = "pattern",
		},
		sf.index(
			f(function(args, snip)
				local capture = snip.captures[1]
				if capture == "s" then
					return "\\limsup"
				elseif capture == "i" then
					return "\\liminf"
				else
					return "\\lim"
				end
			end),
			{
				sn(nil, { i(1), t(" \\to "), i(2) }),
				sn(nil, { i(1) }),
			},
			function(lind)
				return {}
			end
		),
		sf.dont_repeat("lim")
	),
	s({
		trig = "sum",
	}, sf.big_operator("\\sum"), sf.dont_repeat()),
	s({
		trig = "Un",
	}, sf.big_operator("\\bigcup")),
	s({
		trig = "Uns",
	}, sf.big_operator("\\bigsqcup")),
	s({
		trig = "Ir",
	}, sf.big_operator("\\bigcap")),
	s({
		trig = "prod",
	}, sf.big_operator("\\prod"), sf.dont_repeat()),
	s({
		trig = "Or",
	}, sf.big_operator("\\bigvee")),
	s({
		trig = "And",
	}, sf.big_operator("\\bigwedge")),
	s(
		{
			trig = "int",
		},
		sf.index(
			"\\int",
			{
				sn(nil, { i(1, "-\\infty") }),
				sn(nil, { i(1), t(" \\in "), i(2) }),
			},
			---@param lind string
			---@return table
			function(lind)
				if lind:match("^.* \\in .*$") then
					return {}
				else
					return {
						sn(nil, { i(1, "+\\infty") }),
						sn(nil, { t("\\to "), i(1) }),
					}
				end
			end
		),
		sf.dont_repeat()
	),
	s(
		{
			trig = "//",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {
			i(1),
			i(2),
		})
	),
	s(
		{
			trig = "([%a%d])/",
			trigEngine = "pattern",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {
			f(function(args, snip)
				return snip.captures[1]
			end),
			i(1),
		})
	),
	s(
		{
			trig = "/([%a%d])",
			trigEngine = "pattern",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {
			i(1),
			f(function(args, snip)
				return snip.captures[1]
			end),
		})
	),
})
