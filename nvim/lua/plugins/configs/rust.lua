local rt = require('rust-tools')

rt.setup({
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
