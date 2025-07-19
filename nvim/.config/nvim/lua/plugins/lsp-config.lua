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
					"clangd",
					"ts_ls",
					"vue_ls",
					"html",
					"tailwindcss",
					"cssls",
					"gopls",
				},
				automatic_enable = false
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
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*.go",
					callback = function()
						local params = vim.lsp.util.make_range_params(0, "utf-8")
						params.context = { only = { "source.organizeImports" } }
						-- buf_request_sync defaults to a 1000ms timeout. Depending on your
						-- machine and codebase, you may want longer. Add an additional
						-- argument after params if you find that you have to write the file
						-- twice for changes to be saved.
						-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
						local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction",
							params)
						for cid, res in pairs(result or {}) do
							for _, r in pairs(res.result or {}) do
								if r.edit then
									local enc = (vim.lsp.get_client_by_id(cid) or {})
									    .offset_encoding or "utf-16"
									vim.lsp.util.apply_workspace_edit(r.edit, enc)
								end
							end
						end
						vim.lsp.buf.format({ async = false })
					end,
				}),
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
				settings = {
					rulesCustomizations = {
						{ rule = "@stylistic/*", severity = "off" },
					},
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
			local vue_language_server_path = vim.fn.expand("$MASON/packages")
			    .. "/vue-language-server"
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

			lspconfig.clangd.setup({
				capabilities = capabilities
			})

			vim.keymap.set("n", "<F5>", RunDev, { noremap = true, silent = true })
			vim.keymap.set("n", "H", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		end,
	},
}
