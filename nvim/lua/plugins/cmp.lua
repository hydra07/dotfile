return {
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		name = "cmp",
		event = { "LspAttach", "InsertCharPre" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
			{
				"zbirenbaum/copilot-cmp",
				event = { "InsertEnter", "LspAttach" },
				fix_pairs = true,
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			{
				"Jezda1337/nvim-html-css",
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
					"nvim-lua/plenary.nvim",
				},
				-- config = function()
				--     require("html-css"):setup()
				-- end
			},
			{
				"L3MON4D3/LuaSnip",
				name = "LuaSnip",
				dependencies = {
					"evesdropper/luasnip-latex-snippets.nvim",
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
					{
						"honza/vim-snippets",
						config = function()
							require("luasnip.loaders.from_snipmate").lazy_load()
							require("luasnip").filetype_extend("all", { "_" })
						end,
					},
				},
				build = "make install_jsregexp",
				opts = {
					history = true,
					region_check_events = "CursorHold,InsertLeave",
					delete_check_events = "TextChanged,InsertEnter",
				},
				config = function(_, opts)
					require("luasnip").setup(opts)
					local snippets_folder = vim.fn.stdpath "config" .. "/lua/plugins/lsp/snippets/"
					require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
					vim.api.nvim_create_user_command("LuaSnipEdit", function()
						require("luasnip.loaders.from_lua").edit_snippet_files()
					end, {})
				end,
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},
}
