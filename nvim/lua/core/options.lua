local M = {}

function M.format_on_save()
  print("format_on_save turn on!")
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
    pattern = "*",
    desc = "Run LSP formatting on a file on save",
    callback = function()
      if vim.fn.exists(":Format") > 0 then
	vim.cmd.Format()
      end
	end,
})
end

function M.py_config()
  vim.cmd[[ 
    let g:python_recommended_style = 0
    autocmd FileType java setlocal tabstop=2 shiftwidth=2 expandtab
  ]]
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.py" },
    command = "setlocal tabstop=2 shiftwidth=2"
  })
end

function M.highlight_yank()
  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
      vim.highlight.on_yank({ timeout = 150, visual = true })
    end,
  })

end

function M.disable_concealing()
  -- Disable the concealing in some file formats
  -- The default conceallevel is 3 in LazyVim
  vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})
end
function M.turn_off_paste_mode()
  -- Turn off paste mode when leaving insert
   vim.api.nvim_create_autocmd("InsertLeave", {
	  pattern = "*",
	  command = "set nopaste",
  })
end

return M
