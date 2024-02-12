return {
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    event = { "LspAttach" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("null-ls").setup({
            sources = {
              require("null-ls").builtins.formatting.prettier.with({
                extra_args = {
                  "--print-with",
                  "80",
                },
                filetypes = {
                  "typescript",
                  "typescriptreact",
                  "javascript",
                  "vue"
                },
              }),
              require("null-ls").builtins.diagnostics.eslint,
              require("null-ls").builtins.formatting.stylua,
              require("null-ls").builtins.completion.luasnip,
            },
          })
        end
      },
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = { "BufEnter" },
        config = function()
          -- Turn on LSP, formatting, and linting status and progress information
          require("fidget").setup({
            text = {
              spinner = "dots_negative",
            },
          })
        end,
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
}
