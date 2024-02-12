return {
	--Color css/tailwindcss
	{
		"NvChad/nvim-colorizer.lua",
		name = "color",
		event = "VeryLazy",
		opts = {
			filetypes = { "*", cmp_docs = { always_update = true } },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
				tailwind = false,
				sass = { enable = true },
				virtualtext = "■",
				always_update = true,
			},
			buftypes = {},
		},
	},
	{
		"themaxmarchuk/tailwindcss-colors.nvim",
		config = function()
			require("tailwindcss-colors").setup({})
		end,
	},
}
