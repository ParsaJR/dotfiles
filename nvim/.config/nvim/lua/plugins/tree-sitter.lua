return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- configure tree_sitter
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"lua",
				"typescript",
				"html",
				"css",
				"javascript",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"dockerfile",
				"gitignore",
				"markdown",
				"vimdoc",
				"vim",
				"c",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
