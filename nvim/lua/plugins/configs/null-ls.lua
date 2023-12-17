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
				"vue"
			},
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.luasnip,
	},
})
