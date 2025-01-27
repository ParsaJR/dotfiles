return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- configure tree_sitter
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "lua", "html", "css", "javascript" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
