-- this package is support for typescript project
return {
	{
		"dmmulroy/tsc.nvim",
		lazy = false,
		ft = {"typescript", "typescriptreact"},
		config = function()
			require("tsc").setup({
				auto_open_qflist = true,
				petty_errors = true,
			})
		end
	}
}
