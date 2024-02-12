-- local conf_path = vim.fn.stdpath "config" --[[@as string]]
return {
  {
    "onsails/lspkind.nvim",
    config = function()
      local lspkind = require("lspkind")
      lspkind.init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = require("core.icons").kind,
      })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.configs.null-ls")
  --   end,
  -- },
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
  -- {
  --   "rcarriga/nvim-notify",
  --   event = "UiEnter",
  --   config = function()
  --     local opts = require("plugins.configs.settings").notify
  --     require("notify").setup(opts)
  --   end,
  -- },
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
    "iamcco/markdown-preview.nvim",
    -- event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- build = function()
    --   vim.fn["mkdp#util#install"]()
    -- end,
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufReadPost",
  --   main = "ibl",
  --   opts = {},
  --   config = function()
  --     require("plugins.configs.settings").ibl()
  --   end,
  -- },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    event = "VeryLazy",
  },

  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = function()
  --     require("nvim-autopairs").setup()
  --   end,
  -- },
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
  { "yorik1984/newpaper.nvim", event = "VeryLazy" },
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
      { "tpope/vim-rhubarb", event = "VeryLazy" },
      { "tpope/vim-sleuth",  event = "VeryLazy" },
    },
  },
  "tpope/vim-surround",
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
      require("rust-tools").setup({
        tools = {
          inlay_hints = {
            auto = true,
            highlight = "Comment",
          },
        },
        server = {
          standalone = true,
        },
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    lazy = true,
  },
  {
    "echasnovski/mini.cursorword",
    version = "*",
    lazy = true,
    event = "CursorMoved",
  },
}
-- require("lazy").setup(plugins, require("lazy_nvim"))
