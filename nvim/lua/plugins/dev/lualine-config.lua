local lualine = require("lualine")

local split = function(input, delimiter)
	local arr = {}
	string.gsub(input, "[^" .. delimiter .. "]+", function(w)
		table.insert(arr, w)
	end)
	return arr
end

local function get_venv()
	local venv = vim.env.VIRTUAL_ENV
	if venv then
		local params = split(venv, "/")
		return "(env:" .. params[#params - 1] .. ")"
	else
		return ""
	end
end

-- -- Color table for highlights
-- -- stylua: ignore
local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
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

local lsp_status = {
	-- Lsp server name .
	function()
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
				X = client.name .. "," .. X
			end
		end
		if not (X == "") then
			return X:sub(1, -2)
		else
			return msg
		end
	end,
	icon = " LSP:",
	color = { fg = "#ffffff", gui = "bold" },
}

local encoding = {
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = "bold" },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
}
local diff = {
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
}

local mode = {
	"mode",
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			["␖"] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			["␓"] = colors.orange,
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
}

local file_size = {
	"filesize",
	cond = conditions.buffer_not_empty,
}
local file_format = {
	"fileformat",
	fmt = string.upper,
	icons_enabled = false,
	color = { fg = colors.green, gui = "bold" },
}

lualine.setup({
	option = {
		icons_enabled = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", diff, diagnostics },
		lualine_c = { "filename" },
		lualine_x = { encoding, "filetype", get_venv },
		lualine_y = { file_size, "progress" },
		lualine_z = { "location" },
	},
})
