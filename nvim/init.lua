vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("core.base-configs")
local lazy_path = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
require("core.utils").lazy(lazy_path)
require("plugins")
require("core.keymaps")

