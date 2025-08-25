return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>nv", function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							--	["<CR>"] = require("telescope.actions").file_tab,
						},
					},
					file_ignore_patterns = {
						"node_modules",
					},
				},
			})
		end,
	},
}
