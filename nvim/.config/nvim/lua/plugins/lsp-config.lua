return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"ts_ls",
					"volar",
					"html",
					"tailwindcss",
					"cssls",
					"gopls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local mason_registry = require("mason-registry")
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Add 'vim' to the list of globals
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
						},
						telemetry = {
							enable = false, -- Disable telemetry
						},
					},
				},
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						completeUnimported = true,
					},
				},
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html" },
				init_options = {
					provideFormatter = true,
					embeddedLanguages = { css = true, javascript = true },
					--	configurationSection = { "html", "css", "javascript", "vue" },
				},
			})
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
					"vue",
				},
				-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
				-- **Note:** only the options listed in the table are supported.
				init_options = {
					---@type table<string, string>
					includeLanguages = {},
					--- @type string[]
					excludeLanguages = {},
					--- @type string[]
					extensionsPath = {},
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
					preferences = {},
					--- @type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					--- @type "always" | "never" Defaults to `"always"`
					showExpandedAbbreviation = "always",
					--- @type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
					syntaxProfiles = {},
					--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
					variables = {},
				},
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
				filetypes = { "css", "scss", "less" },
			})
			lspconfig.eslint.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
					"html",
					"markdown",
					"json",
					"jsonc",
					"yaml",
					"toml",
					"xml",
					"gql",
					"graphql",
					"astro",
					"svelte",
					"css",
					"less",
					"scss",
					"pcss",
					"postcss",
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
			local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server' 
			lspconfig.ts_ls.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "vue" },
			})
			lspconfig.volar.setup({})
			-- check if the buffer is vue file? if is, open run the pnpm run dev
			function RunDev()
				local buffer = 0
				local bufferName = vim.api.nvim_buf_get_name(buffer)
				if bufferName:sub(-4) == ".vue" then
					vim.cmd("tabnew | terminal pnpm run dev")
					vim.cmd("tabmove $")
				end
				if bufferName:sub(-3) == ".go" then
					vim.cmd("tabnew | terminal go run .")
					vim.cmd("tabmove $")
				end
			end
			vim.keymap.set("n", "<F5>", RunDev, { noremap = true, silent = true })
			vim.keymap.set("n", "H", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n","<leader>e",vim.diagnostic.open_float)
		end,
	},
}
