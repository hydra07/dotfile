local navic = require("nvim-navic")
-- require("nvim-navbuddy").setup()
local navbuddy = require("nvim-navbuddy")
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	if (client.name == "tsserver") or (client.name == "volar") or (client.name == "tailwindcss") then
		-- client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
		client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
		-- client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = false
	else
		client.server_capabilities.documentFormattingProvider = true -- 0.8 and later
		client.server_capabilities.documentRangeFormattingProvider = true
	end

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		navbuddy.attach(client, bufnr)
	end
	-- if client.name ~= 'tailwindcss' then
	--   formatting_callback(client, bufnr)
	--   print(client.name)
	-- end

	-- Create a command `:Format` local to the LSP buffer
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	clangd = {},
	pyright = {
		python = {
			analysis = {
				typeCheckingMode = "off",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
	volar = {
		filetypes = { "vue", "typescript", "javascript", "json" },
	},
	rust_analyzer = {
		filetypes = { "rs" },
	},
	tsserver = {
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
		},
		cmd = { "typescript-language-server", "--stdio" },
	},
	tailwindcss = {
		filetypes = { "html", "css", "scss" },
	},
	cssls = {
		filetypes = { "vue", "css", "scss" },
	},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

navbuddy.setup({})
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup({})

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	on_attach = on_attach,
	capabilities = capabilities,
})

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with({
			extra_args = {
				"--print-with",
				"80",
			},
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascript",
				"vue",
			},
		}),
		null_ls.builtins.formatting.stylua,
	},
})
-- lspconfig
local lspconfig = require("lspconfig")

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" },
})

-- NOTE treesitter
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	rainbow = {
		enable = true,
		disable = {
			"vue",
			"html",
			"css",
			"scss",
			"javascriptreact",
			"typescriptreact",
			"tsx",
			"jsx",
			"javascript.jsx",
			"typescript.tsx",
		},
		extended_mode = true,
		max_file_lines = nil,
	},
})
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	-- ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,
	-- open_on_setup = true,
	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})
