return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"vue_ls",
					"html",
					"tailwindcss",
					"cssls",
					"emmet_language_server",
					"pylsp",
					"stylua",
				},
				automatic_enable = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Get the list of files in runtime directories,
			-- excluding the config directory.

			local runtime_files = vim.api.nvim_get_runtime_file("", true)

			local sep = package.config:sub(1, 1)
			local cfgdir = vim.fn.stdpath("config")

			for i, path in ipairs(runtime_files) do
				local conf_path = vim.fn.stdpath("config")
				if vim.fs.relpath(cfgdir, path) ~= nil then
					table.remove(runtime_files, i)
				end
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.enable("lua_ls")
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							disable = {
								"redefined-local",
								"empty-block",
								"trailing-space",
								"unused-function",
								"unused-local",
								"unused-vararg",
								"undefined-field",
							},
						},
						workspace = {
							library = runtime_files,
							checkThirdParty = "Disable",
						},
					},
				},
				capabilities = capabilities,
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.enable("stylua")

			vim.lsp.enable("pylsp")
			vim.lsp.config("pylsp", {
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { "E231" },
								maxLineLength = 100,
							},
						},
					},
				},
			})
			vim.lsp.enable("gopls")
			vim.lsp.config("gopls", {
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
						local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
						for cid, res in pairs(result or {}) do
							for _, r in pairs(res.result or {}) do
								if r.edit then
									local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
									vim.lsp.util.apply_workspace_edit(r.edit, enc)
								end
							end
						end
						vim.lsp.buf.format({ async = false })
					end,
				}),
			})

			vim.lsp.enable("html")
			vim.lsp.config("html", {
				capabilities = capabilities,
				filetypes = { "html" },
				init_options = {
					provideFormatter = true,
					embeddedLanguages = { css = true, javascript = true },
					--	configurationSection = { "html", "css", "javascript", "vue" },
				},
			})
			vim.lsp.enable("emmet_language_server")
			vim.lsp.config("emmet_language_server", {
				capabilities = capabilities,
				filetypes = {
					"css",
					"eruby",
					"html",
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
			vim.lsp.enable("tailwindcss")
			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
			})
			vim.lsp.config("cssls", {
				capabilities = capabilities,
				filetypes = { "css", "scss", "less" },
			})
			vim.lsp.config("eslint", {
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

			-- VUE_LS
			local vue_language_server_path = vim.fn.stdpath('data')
				.. "/mason/packages"
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"

			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			local ts_ls_config = {
				init_options = {
					plugins = {
						vue_plugin,
					},
				},
				filetypes = tsserver_filetypes,
			}

			local vue_ls_config = {}

			vim.lsp.config("vue_ls", vue_ls_config)
			vim.lsp.config("ts_ls", ts_ls_config)
			vim.lsp.enable({ "ts_ls", "vue_ls" })

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

			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})
			vim.lsp.enable("clangd")

			vim.keymap.set("n", "<F5>", RunDev, { noremap = true, silent = true })

			-- Show docs
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- Go to definition of the function
			vim.keymap.set("n", "<M-.>", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

			-- Go to Back to previous tag history
			vim.keymap.set("n", "<M-,>", "<c-t>")

			-- code actions
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- open diagnostics floating window
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

			-- Open the diagnostic window for showing the entire buffer.
			vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist)
		end,
	},
}
