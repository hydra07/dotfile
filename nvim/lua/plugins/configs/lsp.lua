local lspconfig = require("lspconfig")
-- local windows = require ("lspconfig.ui.windows")
local cmp = require("cmp_nvim_lsp")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local navic = require("nvim-navic")

local servers = {
	clangd = {
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		single_file_support = true,
	},
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
		filetypes = { "rs", "rust" },
		cmd = { "rustup", "run", "stable", "rust-analyzer" }
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
		init_options = {
			hostInfo = "neovim",
		},
		single_file_support = true,
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "literal",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},
	tailwindcss = {
		filetypes = { "html", "css", "scss", "vue", "tsx", "jsx", "ts", "js" },
	},
	cssls = {
		filetypes = { "vue", "css", "scss" },
	},
	lua_ls = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
			},
			hint = {
				enable = true,
			},
		},
	},
	-- emmet_ls = {
	-- 	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" },
	-- },
	bashls = {
		single_file_support = true,
	},
}

local on_attach = function(client, bufnr)
	if (client.name == "tsserver") or (client.name == "volar") or (client.name == "tailwindcss") then
		-- client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
		client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
		-- client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = false

		if (client.name == "tailwindcss" ) then
			require("tailwindcss-colors").buf_attach(bufnr)
		end
	else
		client.server_capabilities.documentFormattingProvider = true -- 0.8 and later
		client.server_capabilities.documentRangeFormattingProvider = true
	end

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		-- navbuddy.attach(client, bufnr)
	end

	-- if client.name ~= 'tailwindcss' then
	--   formatting_callback(client, bufnr)
	--   print(client.name)
	-- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}
lspconfig.util.on_setup = lspconfig.util.add_hook_after(lspconfig.util.on_setup, function(config)
	config.capabilities = vim.tbl_deep_extend("force", config.capabilities, cmp.default_capabilities())
	config.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	config.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
		{ border = "rounded" })
end)
require("lsp-inlayhints").setup()
-- require("lsp-inlayhints").on_attach(client, bufnr)
mason.setup({})
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
require("neodev").setup()
navic.setup({
	highlight = true,
	lazy_update_context = false,
	click = true,
})

