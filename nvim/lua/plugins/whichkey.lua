return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
				},
				icons = {
					breadcrumb = "»",
					separator = "➜ ",
					group = "+",
				},
				window = {
					border = "none", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 },
					padding = { 1, 2, 1, 2 },
					-- winblend = 5,        -- value between 0-100 0 for fully opaque and 100 for fully transparent
					zindex = 1000, -- positive value to position WhichKey above other floating windows.
				},
				layout = {
					height = { min = 5, max = 15 },
					width = { min = 25, max = 35 },
					spacing = 1,
					align = "center",
				},
			})
				require("which-key").register({
			-- ["<leader>s"] = {
			--   name ="Search",
			--   -- f =	{ require('telescope.builtin').find_files, "[S]earch [F]ile" },
			--   -- h = { require('telescope.builtin').help_tags, "[S]earch [H]elp "},
			--
			-- },
			[";"] = {
				name = "Telescope",
				f = { require("telescope.builtin").find_files, "Search File" },
				g = { require("telescope.builtin").live_grep, "Search String" },
				h = { require("telescope.builtin").help_tags, "Search Help" },
				d = { require("telescope.builtin").diagnostics, "Search Diagnostics" },
				t = { require("telescope.builtin").treesitter, "Search Treesitter" },
				w = { require("telescope.builtin").grep_string, "Search Word" },
				r = { require("telescope.builtin").oldfiles, "Recently File" },
				-- e = { require('telescope.builtin').find_files({no_ignore = false,hidden = true}), "Explore File"},
				[";"] = { require("telescope.builtin").resume, "Resume" },
			},
		})

		end,
		},
}
