local lualine = require("lualine")

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

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}
local split = function(input, delimiter)
	local arr = {}
	string.gsub(input, "[^" .. delimiter .. "]+", function(w)
		table.insert(arr, w)
	end)
	return arr
end

-- Config
local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end
ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.red }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	function()
		if vim.fn.mode() == "n" then
			return "⚡ NOR"
		elseif vim.fn.mode() == "i" then
			return "⚡ INS"
		else
			return "⚡    "
		end
	end,
	color = function()
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.orange,
			[""] = colors.orange,
			V = colors.orange,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
})
ins_left({
	"filesize",
	cond = conditions.buffer_not_empty,
})
ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.pastel, gui = "bold" },
})
ins_left({
	function()
		local venv = vim.env.VIRTUAL_ENV
		if venv then
			local params = split(venv, "/")
			return "(env:" .. params[#params - 1] .. ")"
		else
			return ""
		end
	end,
})
ins_left({ "location" })
ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
})
ins_left({
	function()
		return "%="
	end,
})
ins_left({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	color = { fg = "#ffffff", gui = "bold" },
})
ins_left({
	function()
		local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
		if client == nil then
			return ""
		end
		if vim.tbl_isempty(client.requests) then
			return "   "
		end
		local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
		local ms = vim.loop.hrtime() / 1000000
		local frame = math.floor(ms / 120) % #spinners

		return spinners[frame + 1]
	end,
})
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	-- fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = "bold" },
})
ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = colors.green, gui = "bold" },
})
ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})
ins_right({
	"diff",
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})
ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.red },
	padding = { left = 1 },
})
lualine.setup(config)
