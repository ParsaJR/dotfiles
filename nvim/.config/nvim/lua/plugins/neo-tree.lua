return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		-- configure neotree
		Find_buffer_by_type = function(type)
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local ft = vim.api.nvim_buf_get_option(buf, "filetype")
				if ft == type then
					return buf
				end
			end
			return -1
		end
		toggle_neotree = function(toggle_command)
			if Find_buffer_by_type("neo-tree") > 0 then
				require("neo-tree.command").execute({ action = "close" })
			else
				toggle_command()
			end
		end
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				mappings = { ["<cr>"] = "open_tabnew",["t"] = "open" },
			},
			event_handlers = {
				{
					event = "file_open_requested",
					handler = function()
						-- auto close after i opened a file in neo-tree
						vim.cmd("Neotree close")
					end,
				},
			},
		})
	end,
	keys = {
		{
			"<leader>b",
			function()
				toggle_neotree(function()
					require("neo-tree.command").execute({
						action = "focus",
						reveal = true,
						position = "right",
					})
				end)
			end,
			desc = "Find Plugin File",
		},
	},
}
