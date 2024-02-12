-- vim.api.create_autocmd("FileType",{
--   pattern = "oil",
--   callback = function()
--     vim.opt_local.colorcolumn = ""   
--   end,
-- })
return {
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({

      })
    end
  }
}
