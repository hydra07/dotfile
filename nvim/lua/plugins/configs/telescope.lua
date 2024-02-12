-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local a_status, t_actions = pcall(require, 'telescope.actions')
if (not a_status) then
  print("No actions added")
else
  require('telescope').setup {
    defaults = {
      file_ignore_patterns = {
        "node_modules/*",
        ".git/*",
        ".env/",
        ".next",
        "yarn.lock"
      },
      mappings = {
        i = {
          -- ['<C-u>'] = true,
          -- ['<C-d>'] = false,
          ["<C-p>"] = function()
            require("telescope.extensions.file_browser")
          end,
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
require("telescope").load_extension("file_browser")
