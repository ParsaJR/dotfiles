return {
	{
		"tpope/vim-surround",
		config = function() end,
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Draft/writings",
					syntax = "markdown",
					ext = "md",
				},
			}
			vim.keymap.set("n","<C-t>",":VimwikiToggleListItem<CR>")
			vim.g.vimwiki_global_ext = 0
		end,
	},
}
