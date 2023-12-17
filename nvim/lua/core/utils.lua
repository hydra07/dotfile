local M = {}
M.lazy = function(lazypath)
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
  vim.opt.rtp:prepend(lazypath)
end

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        if plugin ~= "treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

local cmds = { "nu!", "rnu!", "nonu!" }
local current_index = 1

function M.toggle_numbering()
  current_index = current_index % #cmds + 1
  vim.cmd("set " .. cmds[current_index])
end

function M.run_command()
  local terminal = require "nvterm.terminal"
  local ft_cmds = {
    rust = "cargo run",
    sh = "bash " .. vim.fn.expand "%",
    python = "python3 " .. vim.fn.expand "%",
    lua = "lua " .. vim.fn.expand "%",
    markdown = "glow " .. vim.fn.expand "%",
  }
  local command = ft_cmds[vim.bo.filetype]

  if command then
    terminal.send("clear && " .. command, "vertical")
  else
    print("No command defined for filetype: " .. vim.bo.filetype)
  end
end

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Disable 'mini.indentscope', enable beam in terminal buffer",
  callback = function(data)
    vim.b[data.buf].miniindentscope_disable = true
  end,
})

local inlay_hint_enabled = true

function M.toggle_inlay_hint()
  if vim.lsp.inlay_hint then
    inlay_hint_enabled = not inlay_hint_enabled
    vim.lsp.inlay_hint(0, inlay_hint_enabled)
    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#f0c6c6" })
  else
    require "notify" "Inlay hint not supported"
  end
end

function M.toggle_dropbar()
  if vim.o.winbar == "" then
    vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
  else
    vim.o.winbar = ""
  end
end

local state = 0
function M.toggle_flow()
  if state == 0 then
    vim.o.relativenumber = false
    vim.o.number = false
    vim.opt.signcolumn = "yes:4"
    vim.o.winbar = ""
    state = 1
  else
    vim.o.relativenumber = true
    vim.opt.signcolumn = "auto"
    vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
    state = 0
  end
end

local signs = { Error = "", Warn = " ", Hint = " ", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


function M.shell()
  if vim.fn.has("win32") == 1 then
    return "pwsh.exe"
  elseif vim.fn.has("unix") == 1 then
    return vim.o.shell
  end
end

function M.get_loc()
  local me = debug.getinfo(1, "S")
  local level = 2
  local info = debug.getinfo(level, "S")
  while info and (info.source == me.source or info.source == "@" .. vim.env.MYVIMRC or info.what ~= "Lua") do
    level = level + 1
    info = debug.getinfo(level, "S")
  end
  info = info or me
  local source = info.source:sub(2)
  source = vim.loop.fs_realpath(source) or source
  return source .. ":" .. info.linedefined
end

function M.getClipboard()
  local has = vim.fn.has
  local is_win = has("win32")
  local is_unix = has("unix")
  local is_wsl = has("wsl")

  if is_unix then
    vim.o.clipboard = 'unnamedplus'
    vim.cmd("set clipboard+=unnamedplus")
    -- vim.o.shell = "fish"
  elseif is_win then
    vim.o.clipboard = 'unnamedplus'
    vim.cmd("set clipboard+=unnamedplus")
  elseif is_wsl then
    vim.g.clipboard = {
      name = 'win31yank',
      copy = {
        ['+'] = 'win31yank -i --crlf',
        ['*'] = 'win31yank -i --crlf'
      },
      paste = {
        ['+'] = 'win31yank -o --lf',
        ['*'] = 'win31yank -o --lf'
      }
    }
  end
end

return M