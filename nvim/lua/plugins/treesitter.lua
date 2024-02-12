return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		-- event = {
		-- 	"BufReadPre",
		-- 	"BufNewFile",
		-- },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- "windwp/nvim-ts-autotag",
			{
				"HiPhish/rainbow-delimiters.nvim",
				config = function()
					local rainbow_delimiters = require("rainbow-delimiters")
					vim.g.rainbow_delimiters = {
						strategy = {
							[""] = rainbow_delimiters.strategy["global"],
							vim = rainbow_delimiters.strategy["local"],
						},
						query = {
							[""] = "rainbow-delimiters",
							lua = "rainbow-blocks",
						},
						highlight = {
							"RainbowDelimiterRed",
							"RainbowDelimiterYellow",
							"RainbowDelimiterBlue",
							"RainbowDelimiterOrange",
							"RainbowDelimiterGreen",
							"RainbowDelimiterViolet",
							"RainbowDelimiterCyan",
						},
					}
				end,
			},
		},
		-- build = function()
		-- 	require("nvim-treesitter.install").update({ with_sync = true })
		-- end,
		-- config = function()
		--
		-- end,
		opts = {
			-- autotag = { enable = true },
			autopairs = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"lua",
				"python",
				"typescript",
				"tsx",
				"json",
				"javascript",
				"rust",
				"html",
				"css",
				"markdown",
			},
			sync_install = false,
			rainbow = {
				enable = true,
				disable = {
					"python",
					"vue",
					"html",
					"css",
					"scss",
				},
				extended_mode = true,
				max_file_lines = nil,
			},
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		-- event = "VeryLazy",
		-- event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"xml",
					"jsx",
					"javascript",
					"javscriptreact",
					"tsx",
					"typescript",
					"typescriptreact",
				},
			})
		end,
	},
}
