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
				settings = {
					gopls = {
						completeUnimported = true,
					},
				},
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "vue" },
				init_options = {
					provideFormatter = false,
					embeddedLanguages = { css = true, javascript = true },
					--	configurationSection = { "html", "css", "javascript", "vue" },
				},
			})
			lspconfig.emmet_language_server.setup({
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
			local vue_language_server_path = mason_registry.get_package("vue-language-server")
			    :get_install_path()
			    .. "/node_modules/@vue/language-server"
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
		end,
	},
}
