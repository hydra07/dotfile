local M = {}

-- shell
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
