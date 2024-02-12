local keymap = vim.keymap


vim.cmd[[ 
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- vim.keymap.set('n', "<M-m>" , ":BufferLineMoveNext<CR>")
-- vim.keymap.set('n', "<M-b>" , ":BufferLineMovePrev<CR>")
vim.keymap.set('n', "<C-s>" , ":w<CR>")
vim.keymap.set('i', "<C-s>" , "<ESC>:w<CR>a")

keymap.set('n', '<Leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', {desc = "Comment"})
keymap.set('v', '<Leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',{desc = "Comment"})
-- Tabs
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })


keymap.set("n", "<M-S>", ":SymbolsOutline<CR>")

-- Do not yank with x or c
keymap.set('n', 'x', '"_x')
keymap.set('n', 'c', '"_c')
-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word
keymap.set('n', 'dw', 'diw')
keymap.set('n','<M-X>', ':<C-U>bprevious <bar> bdelete #<CR>')
keymap.set('n','<leader>x', ':<C-U>bprevious <bar> bdelete #<CR>')
keymap.set('n','<leader>B', ':<C-U>bprevious <bar> bdelete #<CR>')


vim.api.nvim_set_keymap('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', {})
vim.api.nvim_set_keymap('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', {})

vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
vim.cmd("nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>")

-- vim.api.nvim_set_keymap("n", "s", ":HopAnywhere<cr>", { silent = true })
-- vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })

-- Move
keymap.set('', '<C-h>', '<C-w>h')
keymap.set('', '<C-k>', '<C-w>k')
keymap.set('', '<C-j>', '<C-w>j')
keymap.set('', '<C-l>', '<C-w>l')

-- Resize window
keymap.set('n', '<M-H>', '<C-w><')
keymap.set('n', '<M-L>', '<C-w>>')
keymap.set('n', '<M-K>', '<C-w>+')
keymap.set('n', '<M-J>', '<C-w>-')
-- keymap.set('n', 'sh', ':noh<CR>')
keymap.set('n', '<leader>h', ':noh<CR>')
-- keymap.set('n', '<M-Q>', ':qa!<CR>')
keymap.set('n', '<leader>X', ':qa!<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Resume'})
-- vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = 'Treesitter'} )


local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
nmap('<leader>C', '<cmd>ColorizerAttachToBuffer<CR>','Show Color')
nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- See `:help K` for why this keymap
nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
nmap('<leader>l', vim.lsp.buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
nmap('<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, '[W]orkspace [L]ist Folders')

nmap('<leader>N', ':Navbuddy<CR>','Navbuddy')

vim.cmd[[
  inoremap <c-F> <cr><esc><<<<ko<bs>
  inoremap <c-K> <cr><esc><<ko<bs><tab>
]]


nmap('<leader>R', '<cmd>w<cr><cmd>e!<cr>', 'Refresh')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>g', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

nmap('<leader>L', '<cmd>lua vim.diagnostic.open_float({scope="line"}) <CR>', 'Show line diagnostic')
keymap.set('n', '<leader>e', '<cmd>:NvimTreeToggle<CR>')
keymap.set('n', '<leader>Q', '<cmd>:q<CR>')


-- local api_tree = require('nvim-tree.api')
-- local function opts(desc)
--   return { desc = 'nvim-tree: ' .. desc, noremap = true, silent = true, nowait = true }
-- end




vim.keymap.set('n', "<leader>tt" , "<cmd>TroubleToggle<cr>")
vim.keymap.set('n', "<leader>tw" , "<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set('n', "<leader>td" , "<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set('n', "<leader>tq" , "<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle quickfix<cr>")
vim.keymap.set('n', "<leader>tl" , "<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle loclist<cr>")
vim.keymap.set('n', "<leader>tr" , "<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle lsp_references<cr>")

vim.keymap.set('n', "<leader>F" , "<cmd>lua vim.lsp.buf.formatting()<cr>",{desc = "Format"})
vim.keymap.set('n', "<leader>f" , "<cmd>lua vim.lsp.buf.format{async=true}<cr>",{desc = "async Format "})
vim.keymap.set('n', "<M-N>" , "*")



vim.keymap.set('n', "<leader>N" , "*")
vim.keymap.set('n', "<leader>n" , "<cmd>lua require('illuminate').goto_next_reference()<cr>",{desc = "Next"})
vim.keymap.set('n', "<leader>p" , "<cmd>lua require('illuminate').goto_prev_reference()<cr>",{desc = "Previous"})


nmap('<leader>U', ':Navbuddy<CR>','Navbuddy')

vim.keymap.set('n', '<leader>E', '<cmd>lua require("spectre").open()<CR>', {
    desc = "Open Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

vim.keymap.set('x', '<leader>p', '\"_dP')
