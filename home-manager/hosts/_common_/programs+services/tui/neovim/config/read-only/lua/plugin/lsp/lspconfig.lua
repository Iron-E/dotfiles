--[[/* Imports */]]

local lspconfig  = require 'lspconfig'

--[[/* UI */]]

--- Configuration for `nvim_open_win`
local FLOAT_CONFIG = {border = 'rounded'}

--- Event handlers
local HANDLERS =
{
	-- TODO: replace with vim.lsp.protocol.Methods
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, FLOAT_CONFIG),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, FLOAT_CONFIG),
}

if not _G['nvim >= 0.10'] then
	vim.cmd [[
		sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
		sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
		sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
		sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
	]]
end

vim.diagnostic.config
{
	float = FLOAT_CONFIG,
	severity_sort = true,
	signs = { text = { ' ', ' ', ' ', ' ' } },
	virtual_text = { prefix = ' ', source = 'if_many', spacing = 1 },
}

require('lspconfig.ui.windows').default_options = FLOAT_CONFIG

--[[/* Config */]]

do -- disable lsp watcher. Too slow on linux
	local watchfiles = require 'vim.lsp._watchfiles'
	watchfiles._watchfunc = function() return function() end end
end

-- Do not log the LSP
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

local CAPABILITIES = require('cmp_nvim_lsp').default_capabilities()

--- @param lsp string
--- @param config? table
local function setup(lsp, config)
	if config == nil then
		config = {}
	end

	config.capabilities = CAPABILITIES
	config.handlers = HANDLERS
	lspconfig[lsp].setup(config)
end

setup 'csharp_ls'
setup 'docker_compose_language_service'
setup 'graphql'
setup 'html'
setup 'nil_ls'
setup 'tailwindcss'

setup('bashls', {
	filetypes = { 'sh', 'zsh' },
})

setup('emmet_ls', {
	filetypes = {
		'astro',
		'cs',
		'css',
		'eruby',
		'html',
		'htmldjango',
		'javascriptreact',
		'less',
		'pug',
		'sass',
		'scss',
		'svelte',
		'typescriptreact',
		'vue',
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

setup('jdtls', {
	init_options =
	{
		jvm_args = {['java.format.settings.url'] = vim.fn.stdpath('config')..'/eclipse-formatter.xml'},
		workspace = vim.fn.stdpath('cache')..'/java-workspaces',
	},
})

setup('jsonls', {cmd = {'vscode-json-languageserver', '--stdio'}})

setup('lua_ls', {
	before_init = function(_, config)
		local lua_ls_workspace_library = {}

		for _, path in ipairs(vim.api.nvim_get_runtime_file('', true)) do
			lua_ls_workspace_library[path] = true
		end

		local lazy_path = vim.fs.find('lazy', {path = vim.fn.stdpath 'data', type = 'directory'})[1] .. '/'
		for path, path_type in vim.fs.dir(lazy_path) do
			if path_type == 'directory' then
				lua_ls_workspace_library[lazy_path .. path] = true
			end
		end

		config.settings.Lua.workspace = {library = lua_ls_workspace_library}
	end,
	cmd = {'lua-language-server', '-E', '-W'},
	settings = {Lua =
	{
		diagnostics = {globals = { 'vim' }},
		hint = {enable = true},
		runtime =
		{
			path = vim.split(package.path, ';', {plain = true, trimempty = true}),
			pathStrict = true,
			version = 'LuaJIT',
		},
		telemetry = {enable = false},
	}},
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

setup('tsserver', {
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
			schemas = {
				kubernetes = '*.yaml',
				['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
				['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
				['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
				['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
				['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
				['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
				['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
				['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
				['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
				['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
				['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
				['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
			},
		},
	},
})
