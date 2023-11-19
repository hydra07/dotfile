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

return M

