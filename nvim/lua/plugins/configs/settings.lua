local Settings = {}

Settings.whichkey = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  require("which-key").setup({
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },	
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜ ", -- symbol used between a key and it's label
      group = "+",
    },
    window = {
      border = "none",     -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      -- winblend = 5,        -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000,       -- positive value to position WhichKey above other floating windows.
    },
    layout = {
      height = { min = 5, max = 15 }, -- min and max height of the columns
      width = { min = 25, max = 35 }, -- min and max width of the columns
      spacing = 1,               -- spacing between columns
      align = "center",            -- align columns left, center or right
    },
  })

  require("which-key").register({
      -- ["<leader>s"] = {
      --   name ="Search",
      --   -- f =	{ require('telescope.builtin').find_files, "[S]earch [F]ile" },
      --   -- h = { require('telescope.builtin').help_tags, "[S]earch [H]elp "},
      --   
      -- },
      [";"] = {
      	name = "Telescope",
      	f = { require('telescope.builtin').find_files, "Search File" },
      	g = { require('telescope.builtin').live_grep, "Search String" },
      	h = { require('telescope.builtin').help_tags, "Search Help" },
      	d = { require('telescope.builtin').diagnostics, "Search Diagnostics"},
        t = { require('telescope.builtin').treesitter, "Search Treesitter"},
        w = { require('telescope.builtin').grep_string, "Search Word" },
        r = { require('telescope.builtin').oldfiles, 'Recently File'},
        -- e = { require('telescope.builtin').find_files({no_ignore = false,hidden = true}), "Explore File"},
        [";"] = { require('telescope.builtin').resume, "Resume" },
      },
    })
end

Settings.transparent = {
  groups = { -- table: default groups
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLineNr",
    "EndOfBuffer",
    "CursorLine",
    "Telescope",
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
}

Settings.bufferline = {
  options = {
    -- mode = "tabs",
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    color_icons = true,
    indicator = {
      style = "icon",
    },
    close_icon = "",
    diagnostics = "nvim_lsp",
    -- separator_style =  "slant" ,
    show_tab_indicators = true,
    buffer_close_icon = "",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or ""
      return " " .. icon .. count
    end,
  },
}

Settings.notify = {
  fps = 60,
  render = "compact",
  timeout = 5,
  fade_in_slide_out = "fade",
  background_colour = "#000000"
}

Settings.drop = {
  bar = {
    sources = function(buf, _)
      local sources = require "dropbar.sources"
      local utils = require "dropbar.utils"

      local filename = {
        get_symbols = function(buff, win, cursor)
          local path = sources.path.get_symbols(buff, win, cursor)
          return { path[#path] }
        end,
      }

      if vim.bo[buf].ft == "markdown" then
        return {
          filename,
          utils.source.fallback {
            sources.treesitter,
            sources.markdown,
            sources.lsp,
          },
        }
      else
        return {
          filename,
          utils.source.fallback {
            sources.lsp,
            sources.treesitter,
          },
        }
      end
    end,
  },
  menu = {
    quick_navigation = false,
    keymaps = {
      ["<C-c>"] = "<C-w>q",
      ["<ESC>"] = "<C-w>q",
      ["h"] = "<C-w>c",
      ["l"] = function()
        local menu = require("dropbar.api").get_current_dropbar_menu()
        if not menu then
          return
        end
        local cursor = vim.api.nvim_win_get_cursor(menu.win)
        local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
        if component then
          menu:click_on(component, nil, 1, "l")
        end
      end,
    },
  },
}

Settings.noice = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = false,
    inc_rename = false,
    lsp_doc_border = true,
  },
}

Settings.ibl = function()
  local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
  }

  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)

  local status_indent, indent_line = pcall(require, "ibl")
  if (not status_indent) then
    print("Indent blankline not added")
  else
    indent_line.setup{
      indent = {
        highlight = highlight,
        char = '┆', 
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
      scope = { enabled = false },
    }
  end
end

Settings.toggleterm = {
  open_mapping = [[<c-\>]],
  shade_filetypes = {},
  autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  highlights = {
    NormalFloat = {
      link = "Normal",
    },
  },
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true,   -- if set to true (default) the previous terminal mode will be remembered
  direction = "float",
  close_on_exit = true,  -- close the terminal window when the process exits

  shell = require("core.utils").shell(), --set shell   pwsh
  auto_scroll = true,
  float_opts = {
    border = "curved",
  },
}

Settings.illuminate = function()
  require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
  })
  vim.cmd("hi def IlluminatedWordText gui=underline")
end
return Settings
