return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local fp = {".git/", ".cache", "%.o", "%.a", "%.out", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip"}
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>", function()
				builtin.find_files({ hidden = true, file_ignore_patterns = fp})
			end, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>qf", builtin.quickfix, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>nv", function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)
			vim.keymap.set("n", "<leader>g", function()
				builtin.live_grep()
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
