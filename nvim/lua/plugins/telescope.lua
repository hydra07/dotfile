return {
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- build = "make",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				cond = function()
					-- return vim.fn.executable("make") == 1
					return vim.fn.executable("cmake") == 1
				end,
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
			},
			{ "kdheepak/lazygit.nvim", event = "VeryLazy" },
		},
		config = function()
			require("plugins.configs.telescope")
		end,
	},
}
