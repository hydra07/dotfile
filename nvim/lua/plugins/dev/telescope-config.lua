-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local a_status, t_actions = pcall(require, 'telescope.actions')
if (not a_status) then
  print("No actions added")
else
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          -- ['<C-u>'] = true,
          -- ['<C-d>'] = false,
          ["<C-j>"] = t_actions.move_selection_next,
          ["<C-k>"] = t_actions.move_selection_previous,
        },
      },
    },
  }
end
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension("lazygit")