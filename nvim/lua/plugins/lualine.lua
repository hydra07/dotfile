return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local colors = {
				bg = "#27374D",
				fg = "#bbc2cf",
				yellow = "#ECBE7B",
				cyan = "#008080",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#7f00ff",
				magenta = "#c678dd",
				blue = "#51afef",
				red = "#ec5f67",
				pastel = "#c3b1e1",
			}
			local harpoon = require("harpoon.mark")
			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end
				-- Match the branch name to the specified format
				local _, _, ticket_number = string.find(branch, "skdillon/sko%-(%d+)%-")
				-- If the branch name matches the format, display sko-{ticket_number}, otherwise display the full branch name
				if ticket_number then
					return "sko-" .. ticket_number
				else
					return branch
				end
			end

			local function harpoon_component()
				local total_marks = harpoon.get_length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = "—"

				local mark_idx = harpoon.get_current_index()
				if mark_idx ~= nil then
					current_mark = tostring(mark_idx)
				end
				return string.format("󱡅 %s/%d", current_mark, total_marks)
			end

			local function copilot()
				local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
				if client == nil then
					return ""
				end
				if vim.tbl_isempty(client.requests) then
					return ""
				end
				local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
				local ms = vim.loop.hrtime() / 1000000
				local frame = math.floor(ms / 120) % #spinners

				return spinners[frame + 1]
			end

			local function lsp()
				local function get_icons(filetype)
					require("nvim-web-devicons").get_icons(filetype)
				end
				local lsp_icons = {
					lua_ls = "",
					-- null-ls = "hehe",
					clangd = "",
					bashls = "",
					emmet_ls = "",
					tailwindcss = "󱏿",
					tsserver = "",
					rust_analyzer = "",
					html = "",
					cssls = "",
					pyright = "",
					volar = "󰡄",
				}

				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				local X = ""
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						-- X = client.name .. "," .. X
						if client.name == "null-ls" then
							X = "" .. "," .. X
						else
							X = lsp_icons[client.name] .. "," .. X
						end
					end
				end
				if not (X == "") then
					return X:sub(1, -2)
				else
					return msg
				end
			end

			-- local function ins_left(component)
			-- 	table.insert(, component)
			-- end
			-- local ins_left({
			-- 	function()
			-- 		if vim.fn.mode() == "n" then
			-- 			return "⚡ NOR"
			-- 		elseif vim.fn.mode() == "i" then
			-- 			return "⚡ INS"
			-- 		else
			-- 			return "⚡    "
			-- 		end
			-- 	end,
			-- 	color = function()
			-- 		local mode_color = {
			-- 			n = colors.red,
			-- 			i = colors.green,
			-- 			v = colors.orange,
			-- 			[""] = colors.orange,
			-- 			V = colors.orange,
			-- 			c = colors.magenta,
			-- 			no = colors.red,
			-- 			s = colors.orange,
			-- 			S = colors.orange,
			-- 			[""] = colors.orange,
			-- 			ic = colors.yellow,
			-- 			R = colors.violet,
			-- 			Rv = colors.violet,
			-- 			cv = colors.red,
			-- 			ce = colors.red,
			-- 			r = colors.cyan,
			-- 			rm = colors.cyan,
			-- 			["r?"] = colors.cyan,
			-- 			["!"] = colors.red,
			-- 			t = colors.red,
			-- 		}
			-- 		return { fg = mode_color[vim.fn.mode()] }
			-- 	end,
			-- 	padding = { right = 1 },
			-- })
			--
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
					-- component_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					section_separators = { left = "█", right = "█" },
				},
				sections = {
					-- lualine_a = {
					-- 	ins_left,
					-- },
					lualine_b = {
						{ "branch", icon = "", fmt = truncate_branch_name },
						harpoon_component,
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
						lsp,
						copilot,
					},
					lualine_x = {
						-- copilot,
						"filetype",
					},
				},
			})
		end,
	},
}
