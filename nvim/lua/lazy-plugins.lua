return {

  -- NOTE: First, some plugins that don't require any configuration

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },
  "onsails/lspkind.nvim",
  {
    "L3MON4D3/LuaSnip",
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

          -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
          -- are stored in `ls.snippets._`.
          -- We need to tell luasnip that "_" contains global snippets:
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
    -- stylua: ignore
    -- keys = {
    --   {
    --     "<Tab>",
    --     function()
    --       return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
    --     end,
    --     expr = true, remap = true, silent = true, mode = "i",
    --   },
    --   { "<Tab>", function() require("luasnip").jump(1) end, mode = "s" },
    --   { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- },
    config = function(_, opts)
      require("luasnip").setup(opts)

      local snippets_folder = vim.fn.stdpath "config" .. "/lua/plugins/lsp/snippets/"
      require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

      vim.api.nvim_create_user_command("LuaSnipEdit", function()
        require("luasnip.loaders.from_lua").edit_snippet_files()
      end, {})
    end,
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip" },
  },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
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
  -- Tabnine
  { "codota/tabnine-nvim", build = "./dl_binaries.sh" },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter", "LspAttach" },
    fix_pairs = true,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- "github/copilot.vim",
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
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    -- config = function()
    --   pcall(require("nvim-treesitter.install").update({ with_sync = false }))
    -- end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "jayp0521/mason-nvim-dap.nvim",
    -- event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    -- enabled = vim.fn.has "win32" == 0,
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  "jose-elias-alvarez/null-ls.nvim",

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  -- { import = 'custom.plugins' },
}
