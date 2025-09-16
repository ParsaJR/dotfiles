return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.cmd([[autocmd BufReadPost fugitive://* set bufhidden=delete"]])

			vim.cmd([[set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P]])
		end,

	},
}
