-- local conf_path = vim.fn.stdpath "config" --[[@as string]]
local plugins = {
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    name = "catppuccin",
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end,
    config = function()
      local opts = require "plugins.configs.colorscheme"
      require("catppuccin").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    event = { "LspAttach" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "j-hui/fidget.nvim", tag = "legacy", opts = {}
      },
      "folke/neodev.nvim",
      "aca/emmet-ls",
      "derektata/lorem.nvim",
      "lvimuser/lsp-inlayhints.nvim",
      -- "tikhomirov/vim-glsl",
    },
    init = function()
      require("core.utils").lazy_load("lspconfig")
    end,
    config = function()
      require("plugins.configs.lsp")
    end,
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      local lspkind = require("lspkind")
      lspkind.init({
        mode = 'symbol_text',
        preset = 'codicons',
        symbol_map = require("core.icons").kind
      })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    name = "cmp",
    event = { "LspAttach", "InsertCharPre" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      {
        "zbirenbaum/copilot-cmp",
        event = { "InsertEnter", "LspAttach" },
        fix_pairs = true,
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      {
        "Jezda1337/nvim-html-css",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-lua/plenary.nvim",
        },
        -- config = function()
        --     require("html-css"):setup()
        -- end
      },
      {
        "L3MON4D3/LuaSnip",
        name = "LuaSnip",
        dependencies = {
          "evesdropper/luasnip-latex-snippets.nvim",
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
          {
            "honza/vim-snippets",
            config = function()
              require("luasnip.loaders.from_snipmate").lazy_load()
              require("luasnip").filetype_extend("all", { "_" })
            end,
          },
        },
        build = "make install_jsregexp",
        opts = {
          history = true,
          region_check_events = "CursorHold,InsertLeave",
          delete_check_events = "TextChanged,InsertEnter",
        },
        config = function(_, opts)
          require("luasnip").setup(opts)
          local snippets_folder = vim.fn.stdpath "config" .. "/lua/plugins/lsp/snippets/"
          require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
          vim.api.nvim_create_user_command("LuaSnipEdit", function()
            require("luasnip.loaders.from_lua").edit_snippet_files()
          end, {})
        end,
      },
    },
    config = function()
      require("plugins.configs.cmp")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
      require("plugins.configs.treesitter")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      -- require("core.utils").lazy_load("lualine")
      require("plugins.configs.lualine")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.null-ls")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim",
          "nvim-lua/plenary.nvim"
        },
      },
      { "kdheepak/lazygit.nvim", event = "VeryLazy" },
    },
    config = function()
      require("plugins.configs.telescope")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      local opts = require("plugins.configs.settings").bufferline
      -- require("core.utils").lazy_load("bufferline")
      require("bufferline").setup(opts)
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.settings").whichkey()
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    config = function()
      local opts = require("plugins.configs.settings").transparent
      require("transparent").setup(opts)
    end
  },
  --- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    name = "toggleterm",
    config = function()
      local opts = require("plugins.configs.settings").toggleterm
      require("toggleterm").setup(opts)
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "UiEnter",
    config = function()
      local opts = require("plugins.configs.settings").notify
      require("notify").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    name = "noice",
    event = "UiEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = function()
      return require("plugins.configs.settings").noice
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    -- version = "*",
    lazy = false,
    dependencies = {
      {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
        config = function()
          require("nvim-navic").setup()
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      symbols = {},
      kinds = {},
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    -- event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {},
    config = function()
      require("plugins.configs.settings").ibl()
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    event = "VeryLazy"
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    opts = {},
  },
  { "rmagatti/goto-preview" },
  -- {
  -- 	"folke/todo-comments.nvim",
  -- 	event = "BufRead",
  -- 	config = function()
  -- 		require("todo-comments").setup()
  -- 	end,
  -- },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },
  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  { 'yorik1984/newpaper.nvim', event = "VeryLazy" },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      -- "Gdiffsplit",
      "Gvdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
    event = "VeryLazy",
    dependencies = {
      { 'tpope/vim-rhubarb', event = "VeryLazy" },
      { 'tpope/vim-sleuth',  event = "VeryLazy" },
    }
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.configs.settings").illuminate()
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    name = "Rust",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("plugins.configs.rust")
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    name = "color",
    event = "VeryLazy",
    opts = {
      filetypes = { "*", cmp_docs = { always_update = true} },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = false,
        sass = { enable = true },
        virtualtext = "■",
        always_update = true,
      },
      buftypes = {},
    }
  }
}
require("lazy").setup(plugins, require("lazy_nvim"))
