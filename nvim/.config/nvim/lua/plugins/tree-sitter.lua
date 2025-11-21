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
				"json",
				"python",
			},
			auto_install = false,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>", -- set to `false` to disable one of the mappings
					node_incremental = "<C-space>",
					scope_incremntal = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
