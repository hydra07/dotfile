return {
	-- Dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			require("dashboard").setup({})
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				-- mode = "tabs",
				always_show_bufferline = true,
				show_buffer_close_icons = true,
				color_icons = true,
				indicator = {
					-- icon = " 喇",
					style = "icon",
				},
				close_icon = "",
				diagnostics = "nvim_lsp",
				-- separator_style =  "slant" ,
				show_tab_indicators = true,
				buffer_close_icon = "",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or ""
					return " " .. icon .. count
				end,
			},
		},
	},

	-- Lualine
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		-- opts = {
		-- 	options = {
		-- 		icons_enabled = true,
		-- 		theme = "tokyonight",
		-- 		-- component_separators = '|',
		-- 		-- section_separators = '',
		-- 		component_separators = { left = "", right = "" },
		-- 		section_separators = { left = "", right = "" },
		-- 	},
		-- },
	},
	-- Ui
	{ "MunifTanjim/nui.nvim" },

	-- Theme
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
		  vim.cmd.colorscheme 'onedark'
		end,
	},
	{ "ellisonleao/gruvbox.nvim" },
	{ "tiagovla/tokyodark.nvim" },
	{ "folke/tokyonight.nvim", branch = "main" },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue or blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = true, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = false, -- Enable tailwind colors
				-- parsers can contain values used in |user_default_options|
				sass = { enable = true }, -- Enable sass colors
				virtualtext = "■",
				-- update color values even if buffer is not focused
				-- example use: cmp_menu, cmp_docs
				always_update = false,
			},
			buftypes = {},
		},
	},
	-- { 'mrjones2014/nvim-ts-rainbow' },

	-- Trasnparent ui
	{
		"xiyaowong/transparent.nvim",
		opts = {
			groups = { -- table: default groups
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLineNr",
				"EndOfBuffer",
				"CursorLine",
				"Telescope",
			},
			extra_groups = {}, -- table: additional groups that should be cleared
			exclude_groups = {}, -- table: groups you don't want to clear
		},
	},
	-- Dressing
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	-- Noitice
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true,
	-- 			},
	-- 			hover = {
	-- 				enable = true,
	-- 				silent = false,
	-- 				view = nil,
	-- 				---@type NoticeViewOptions
	-- 				opts = {},
	-- 			},
	-- 			messages = {
	-- 				enable = true,
	-- 				view = "notify",
	-- 				opts = {},
	-- 			},
	-- 			documentation = {
	-- 				view = "hover",
	-- 				opts = {
	-- 					lang = "markdown",
	-- 					replace = true,
	-- 					render = "plain",
	-- 					format = { "{message}" },
	-- 					win_options = { concealcursor = "n", conceallevel = 3 },
	-- 				},
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			bottom_search = true, -- use a classic bottom cmdline for search
	-- 			command_palette = true, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 		},
	-- 		views = {
	-- 			cmdline_popup = {
	-- 				position = {
	-- 					row = 5,
	-- 					col = "50%",
	-- 				},
	-- 				size = {
	-- 					width = 60,
	-- 					height = "auto",
	-- 				},
	-- 			},
	-- 			popupmenu = {
	-- 				relative = "editor",
	-- 				position = {
	-- 					row = 8,
	-- 					col = "50%",
	-- 				},
	-- 				size = {
	-- 					width = 60,
	-- 					height = 10,
	-- 				},
	-- 				border = {
	-- 					style = "rounded",
	-- 					padding = { 0, 1 },
	-- 				},
	-- 				win_options = {
	-- 					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
	-- 				},
	-- 			},
	-- 		},
	-- 		format = {
	-- 			cmdline = { pattern = "^:", icon = "", lang = "vim" },
	-- 			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
	-- 			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
	-- 			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
	-- 			lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
	-- 			help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
	-- 			input = {}, -- Used by input()
	-- 		},
	-- 		messages = {
	-- 			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
	-- 			-- This is a current Neovim limitation.
	-- 			enabled = true, -- enables the Noice messages UI
	-- 			view = "notify", -- default view for messages
	-- 			view_error = "notify", -- view for errors
	-- 			view_warn = "notify", -- view for warnings
	-- 			view_history = "messages", -- view for :messages
	-- 			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
}
