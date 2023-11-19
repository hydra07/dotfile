return {
	"aca/emmet-ls",

	"derektata/lorem.nvim",
	"tikhomirov/vim-glsl",
	{
		"nvim-pack/nvim-spectre",
		opts = {},
	},
	-- Indent-blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		main = "ibl",
		opts = {},
	},

	-- statusline/winbar component
	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("nvim-navic").setup()
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		lazy = false,
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			symbols = {},
			kinds = {},
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{ "folke/which-key.nvim", opts = {} },

	{ "kdheepak/lazygit.nvim" },
	{ "windwp/nvim-autopairs" },
	{
		"simrat39/symbols-outline.nvim",
		opts = {},
	},
	{ "rmagatti/goto-preview" },

	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"SmiteshP/nvim-navbuddy",
		requires = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
		},
	},
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			-- "Gdiffsplit",
			"Gvdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	},
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
			highlights = {
				-- highlights which map to a highlight group name and a table of it's values
				-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
				NormalFloat = {
					link = "Normal",
				},
			},
			shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
			persist_size = true,
			persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
			direction = "float",
			close_on_exit = true, -- close the terminal window when the process exits

			-- shell = vim.o.shell, -- change the default shell
			shell = require("until").shell(), --set shell   pwsh

			auto_scroll = true, -- automatically scroll to the bottom on terminal output
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "curved",
				-- like `size`, width and height can be a number or function which is passed the current terminal
				-- winblend = 3,
			},
		},
	},
	{ "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
}
