return {
	-- https://github.com/stevearc/conform.nvim
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				bash = { "shfmt", "beautysh", "shellharden" },
				python = { "isort", "black", "prettier" },
				cpp = { "clang_format", "uncrustify" },
				lua = { "stylua" },
				ruby = { "rubocop" },
				markdown = {
					"prettier",
					-- "mdformat",
					"markdown_toc",
					-- "textlint",
				},
				cmake = { "cmake_format" },
				sql = { "sqlfluff" },
				tex = { "latexindent" },
				css = { "css_beautify" },
				["*"] = {
					-- "codespell",
					"typos",
					-- "prettier",
					-- "trim_whitespace",
				},
				["_"] = { "prettier", "trim_whitespace" },
			},
			-- formatters = {
			-- 	latexindent = {
			-- 		prepend_args = { "--cruft=~/tmp/latexindent" },
			-- 	},
			-- },
		})

		require("conform").formatters.latexindent = {
			prepend_args = { "--cruft=/tmp/latexindent" },
		}

		vim.keymap.set({ "n", "v" }, "<leader>bf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		---@type conform.FileFormatterConfig
		local latexindent = {
			meta = {
				url = "https://github.com/cmhughes/latexindent.pl",
				description = "A perl script for formatting LaTeX files that is generally included in major TeX distributions.",
			},
			command = "latexindent",
			args = { "-" },
			range_args = function(_, ctx)
				return { "--lines", ctx.range.start[1] .. "-" .. ctx.range["end"][1], "-" }
			end,
			stdin = true,
		}
	end,
}
