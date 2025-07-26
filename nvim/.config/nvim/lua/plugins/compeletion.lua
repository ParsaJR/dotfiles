return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local cmp = require("cmp")

			local cmp_confirm = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			})
			-- don't confirm for signature help to allow new line without selecting argument name
			local confirm = cmp.sync(function(fallback)
				local e = cmp.core.view:get_selected_entry()


				if e and e.source.name == "nvim_lsp_signature_help" then
					fallback()
				else
					cmp_confirm(fallback)
				end
			end)
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						--vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- The keybinding for completion window
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.scroll_docs(-4),
					["<C-j>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = confirm, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "nvim_lsp_signature_help" },
				}),
			})


		end,
	},
}
