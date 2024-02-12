return {
	{
		"catppuccin/nvim",
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		config = function()
			local utils = require("catppuccin.utils.colors")
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					treesitter = true,
					treesitter_context = true,
					harpoon = true,
					illuminate = true,
					indent_blankline = {
						enabled = false,
						scope_color = "sapphire",
						colored_indent_levels = false,
					},
					mason = true,
					nvimtree = true,
					neotree = true,
					symbols_outline = true,
					telescope = true,
					dropbar = {
						enabled = true,
						color_mode = false,
					},
					noice = true,
					notify = true,
					native_lsp = {
						enabled = true,
						inlay_hints = {
							background = true,
						},
					},
					barbecue = {
						bold_basename = false,
						dim_context = true,
					},
					mini = {
						enabled = true,
						indentscope_color = "lavender",
					},
				},
				compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
				compile = true,
				flavour = "macchiato",
				custom_highlights = function(palette)
					return {
						["DiagnosticLineError"] = {
							bg = utils.darken(palette.red, 0.095, palette.base),
						},
						["DiagnosticLineWarn"] = {
							bg = utils.darken(palette.yellow, 0.095, palette.base),
						},
						["DiagnosticLineInfo"] = {
							bg = utils.darken(palette.sky, 0.095, palette.base),
						},
						["DiagnosticLineHint"] = {
							bg = utils.darken(palette.teal, 0.095, palette.base),
						},

						["CmpItemMenu"] = {
							fg = palette.overlay0,
						},
					}
				end,
			})
		end,
	},
}
