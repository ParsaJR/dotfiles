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
			vim.keymap.set("n", "<leader>qf", builtin.quickfix, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>nv", function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)
			vim.keymap.set("n", "<leader>g", function()
				builtin.live_grep({
					vimgrep_arguments = {
						"grep",
						"--extended-regexp",
						"--color=never",
						"--with-filename",
						"--line-number",
						"-b", -- grep doesn't support a `--column` option :(
						"--ignore-case",
						"--recursive",
						"--no-messages",
						"--exclude-dir=*cache*",
						"--exclude-dir=*.git",
						"--exclude=.*",
						"--binary-files=without-match",
						-- git grep also works but limits to only git directories,the above works perfectly
						-- "git", "grep", "--full-name", "--line-number", "--column", "--extended-regexp", "--ignore-case",
						-- "--no-color", "--recursive", "--recurse-submodules", "-I"
					},
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
