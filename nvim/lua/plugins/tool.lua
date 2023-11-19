return {
  
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  'yorik1984/newpaper.nvim',
  

  "HiPhish/rainbow-delimiters.nvim",

  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  },
  {
    "mg979/vim-visual-multi",
    config = function()
      vim.cmd [[
      nmap   <M-C-j>         <Plug>(VM-Add-Cursor-Down)
      nmap   <M-C-k>         <Plug>(VM-Add-Cursor-Up)
      nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
      nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)
      nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)
      ]]
    end
  },

  -- Flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "RRethy/vim-illuminate",
  }


}