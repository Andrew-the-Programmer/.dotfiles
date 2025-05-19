return {
	-- https://github.com/nvim-treesitter/nvim-treesitter
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"latex-lsp/tree-sitter-latex",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ignore_install = { "latex" },
			ensure_installed = {
				"c",
				"cpp",
				"javascript",
				"typescript",
				"lua",
				"rust",
				"bash",
				"latex",
				"json",
				"vim",
				"markdown",
				"sql",
				"python",
			},

			sync_install = false,
			auto_install = true,

			indent = {
				enable = true,
				disable = { "latex" },
			},

			highlight = {
				enable = true,
				disable = { "latex", "markdown" },
				-- Ultisnips stop working in markdown
				-- disable = { "latex" },
				additional_vim_regex_highlighting = { "latex", "markdown" },
				-- additional_vim_regex_highlighting = { "latex" },
			},
		})
		-- vim.opt.additional_vim_regex_highlighting = true
		vim.keymap.set("n", "<localleader>s", function()
			-- vim.cmd('eval \'join(map(synstack(line("."), col(".")), synIDattr(v:val, "name")), " > ")\'')
			vim.cmd([[
                echo join(map(synstack(line("."), col(".")), "synIDattr(v:val, 'name')"), " > ")
            ]])
			-- vim.cmd([[
			--              for id in synstack(line("."), col("."))
			--                  echo synIDattr(id, "name")
			--              endfor
			--          ]])
			-- vim.cmd('eval \'synstack(line("."), col("."))\'')
		end)
	end,
}
