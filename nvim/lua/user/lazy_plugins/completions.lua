return {
	{
		-- https://github.com/windwp/nvim-autopairs
		-- complete double ", (, [, { etc...
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"quangnguyen30192/cmp-nvim-ultisnips",
		dependencies = { "SirVer/ultisnips" },
		opts = {},
	},
	{
		-- https://github.com/hrsh7th/nvim-cmp
		"hrsh7th/nvim-cmp",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			-- AI
			"zbirenbaum/copilot-cmp",

			-- snippets
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"SirVer/ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",

			"onsails/lspkind.nvim",
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",

			"kristijanhusak/vim-dadbod-ui",
		},
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			-- Integrate nvim-autopairs with cmp
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				-- cmp.mapping.preset.insert({...}) to keep default mappings
				mapping = {
					-- Works with telescope
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-l>"] = cmp.mapping.confirm({ select = true }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- ["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),

					--[[ Accept currently selected item.
                         Set `select` to `false` to only confirm explicitly selected items.
                    ]]
					-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{
						name = "ultisnips",
					},
				}, {
					{
						name = "nvim_lsp",
					},
					{
						name = "vim-dadbod-completion",
					},
				}, {
					{
						name = "codeium",
						max_item_count = 3,
					},
					{
						name = "buffer",
						max_item_count = 3,
					},
					{
						name = "path",
						max_item_count = 3,
					},
				}, {
					{
						name = "nvim-lsp-signature-help",
						max_item_count = 3,
					},
				}, {
					-- AI
					-- Don't have it, too broke 😭
					-- { name = "copilot", max_item_count = 3, group_index = 4 },
					{
						name = "lazydev",
						max_item_count = 3,
						-- group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
				}),

				-- Enable pictogram icons for lsp/autocompletion
				formatting = {
					expandable_indicator = true,
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						menu = {
							ultisnips = "[UltiSnips]",
							nvim_lsp = "[LSP]",
							buffer = "[Buffer]",
							path = "[PATH]",
							luasnip = "[LuaSnip]",
							lazydev = "[LazyDev]",
							copilot = "[Copilot]",
						},
					}),
				},
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
