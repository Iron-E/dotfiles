-- HACK: see https://github.com/neovim/neovim/issues/33577
vim.lsp.config('ts_ls', {
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
})

--- @type vim.lsp.Config
return {
	init_options = {
		preferences = {
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
	workspace_required = true,
}
