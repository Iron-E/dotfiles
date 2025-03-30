--- Event handlers
--- @type { [string]?: lsp.Handler }
local HANDLERS

return {
	{ 'neovim/nvim-lspconfig',
		cond = vim.g.man ~= true,
		dependencies = 'blink.cmp',
		config = function()
			local lspconfig  = require 'lspconfig'

			--[[/* UI */]]

			--- @type vim.diagnostic.Opts.Float
			local float_config = vim.diagnostic.config().float
			require('lspconfig.ui.windows').default_options = float_config

			--[[/* Config */]]
			local DEFAULT_CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
			local BLINK_CAPABILITIES = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

			--- @param lsp string
			--- @param config? table
			local function setup(lsp, config)
				if config == nil then
					config = {}
				end

				config.capabilities = BLINK_CAPABILITIES
				config.handlers = HANDLERS
				lspconfig[lsp].setup(config)
			end

			setup 'ansiblels'
			setup 'docker_compose_language_service'
			setup 'dockerls'
			setup 'html'
			setup 'jsonnet_ls'
			setup 'nixd'
			setup 'tailwindcss'
			setup 'tinymist'

			setup('bashls', {
				filetypes = { 'sh', 'zsh' },
			})

			setup('emmet_language_server', {
				filetypes = {
					'cs',
					'css',
					'eruby',
					'html',
					'htmlangular',
					'htmldjango',
					'javascriptreact',
					'less',
					'pug',
					'sass',
					'scss',
					'typescriptreact',
					'xml',
				},
				init_options = {
					includeLanugages = { cs = 'xml' },
					showAbbreviationSuggestions = true,
					showExpandedAbbreviation = true,
					showSuggestionsAsSnippets = true,
					syntaxProfiles = { html = 'xhtml' },
				},
			})

			setup('gopls', {
				--- @param client vim.lsp.Client
				on_attach = function(client)
					if not client.server_capabilities.semanticTokensProvider then
						local semantic = vim.tbl_get(client, 'config', 'capabilities', 'textDocument', 'semanticTokens')
						if semantic then
							vim.notify_once(
								client.name .. ' supports semantic tokens but did not report it. Implementing workaround',
								vim.log.levels.INFO
							)

							client.server_capabilities.semanticTokensProvider =
							{
								full = true,
								legend = {tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes},
								range = true,
							}
						end
					end
				end,
				settings = {gopls = {semanticTokens = true}}
			})

			setup('harper_ls', {
				settings = {
					['harper-ls'] = {
						linters = {
							expand_time_shorthands = false,
							ExpandTimeShorthands = false,
							sentence_capitalization = false,
							SentenceCapitalization = false,
							Spaces = false,
							spaces = false,
							spell_check = false,
							SpellCheck = false,
						},
					},
				}
			})

			setup('jdtls', {
				init_options =
				{
					jvm_args = { ['java.format.settings.url'] = vim.fn.stdpath('config')..'/eclipse-formatter.xml' },
				},
			})

			setup('jsonls', { cmd = { 'vscode-json-languageserver', '--stdio' } })

			setup('lua_ls', {
				cmd = { 'lua-language-server', '-E', '-W' },
				settings = {
					Lua = {
						diagnostics = { globals = { 'vim' } },
						hint = { enable = true },
						runtime = {
							path = vim.split(package.path, ';', { plain = true, trimempty = true }),
							pathStrict = true,
							version = 'LuaJIT',
						},
						telemetry = { enable = false },
					},
				},
			})

			setup('pyright', {
				settings =
				{
					python =
					{
						analysis =
						{
							diagnosticSeverityOverrides =
							{
								reportInvalidTypeVarUse = 'none',
								reportMissingTypeStubs = 'none',
								reportUnknownArgumentType = 'none',
								reportUnknownLambdaType = 'none',
								reportUnknownMemberType = 'none',
								reportUnknownParameterType = 'none',
								reportUnknownVariableType = 'none',
							},

							typeCheckingMode = 'strict',
						},
					},
				},
			})

			setup('rust_analyzer', {
				settings =
				{
					['rust-analyzer'] =
					{
						checkOnSave = { extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" } },
						diagnostics = { disabled = { 'inactive-code' } },
					},
				},
			})

			setup('sqlls', {
				cmd = {'sql-language-server', 'up', '--method', 'stdio'},
				filetypes = {'mysql', 'plsql', 'sql'},
			})

			setup('terraformls', {
				filetypes = { 'terraform', 'terraform-vars', 'tf' },
			})

			setup('ts_ls', {
				init_options =
				{
					preferences =
					{
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = 'all',
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					},
				},
			})

			setup('yamlls', {
				filetypes = { 'yaml' },
				settings = {
					yaml = {
						schemas = { -- SEE: https://www.schemastore.org/json/
							kubernetes = '*.{yml,yaml}',
							['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
							['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
							['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
							['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
							['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
							['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
							['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
							['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '*gitlab-ci*.{yml,yaml}',
							['https://golangci-lint.run/jsonschema/golangci.jsonschema.json'] = '.golangci.{yml,yaml,toml,json}',
							['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
							['https://json.schemastore.org/pre-commit-config.json'] = '.pre-commit-config.yaml',
							['https://nfpm.goreleaser.com/static/schema.json'] = '*nfpm*.{yml,yaml}',
							['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
							['https://raw.githubusercontent.com/chainguard-dev/apko/main/pkg/build/types/schema.json'] = '*apko*.{yml,yaml}',
							['https://raw.githubusercontent.com/chainguard-dev/melange/main/pkg/config/schema.json'] = '*melange*.{yml,yaml}',
							['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
							['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/refs/heads/main/schemas/v3.1/schema.yaml'] = '*api*.{yml,yaml}',
						},
					},
				},
			})
		end,
	},
	{ 'seblj/roslyn.nvim',
		dependencies = { 'nvim-lspconfig' },
		ft = 'cs',
		opts = function(_, o)
			o.exe = 'Microsoft.CodeAnalysis.LanguageServer'
			o.config = {
				handlers = HANDLERS,
				settings = {
					['csharp|background_analysis'] = {
						dotnet_analyzer_diagnostics_scope = 'fullSolution',
						dotnet_compiler_diagnostics_scope = 'fullSolution',
					},
					['csharp|code_lens'] = {
						dotnet_enable_references_code_lens = true,
						dotnet_enable_tests_code_lens = true,
					},
					['csharp|completion'] = {
						dotnet_provide_regex_completions = true,
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
					['csharp|inlay_hints'] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					['csharp|symbol_search'] = {
						dotnet_search_reference_assemblies = true,
					},
				},
			}
		end,
	},
}
