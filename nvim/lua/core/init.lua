require("core.base-configs")
require("core.lazy")
require("core.keymaps")
if vim.g.neovide then
  require("core.neovide")
end
-- Options
local options = require("core.options")
options.format_on_save()
options.py_config()
options.highlight_yank()
-- options.disable_concealing()
-- options.turn_off_paste_mode()
