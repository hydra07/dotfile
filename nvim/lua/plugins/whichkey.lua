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
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜ ", -- symbol used between a key and it's label
					group = "+",
				},
				window = {
					border = "none",     -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
					padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
					-- winblend = 5,        -- value between 0-100 0 for fully opaque and 100 for fully transparent
					zindex = 1000,       -- positive value to position WhichKey above other floating windows.
				},
				layout = {
					height = { min = 5, max = 15 }, -- min and max height of the columns
					width = { min = 25, max = 35 }, -- min and max width of the columns
					spacing = 1,               -- spacing between columns
					align = "center",            -- align columns left, center or right
				},
			})

		require("which-key").register({
				["<leader>s"] = {
					name ="Search",
					-- f =	{ require('telescope.builtin').find_files, "[S]earch [F]ile" },
					-- h = { require('telescope.builtin').help_tags, "[S]earch [H]elp "},
					
				},
				-- [";"] = {
				-- 	name = "Telescope",
				-- 	f = { require('telescope.builtin').find_files, "Search File" },
				-- 	r = { require('telescope.builtin').live_grep, "Search String" },
				-- 	h = { require('telescope.builtin').help_tags, "Search Help" },
				-- 	[";"] = { require('telescope.builtin').resume, "Resume" },
				-- },
			})
		end,
	},
}
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

