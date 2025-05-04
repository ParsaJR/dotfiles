return {
	{
		"NMAC427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{
		{
			"nvimdev/indentmini.nvim",
			config = function()
				require("indentmini").setup()
				vim.cmd.highlight('IndentLine guifg=#555555')
				vim.cmd.highlight('IndentLineCurrent guifg=#FFC0CB')
			end,
		},
	},
}
