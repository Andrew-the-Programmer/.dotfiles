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
				["*"] = {
					-- "codespell",
					"typos",
					-- "prettier",
					-- "trim_whitespace",
				},
				["_"] = { "prettier", "trim_whitespace" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>bf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
