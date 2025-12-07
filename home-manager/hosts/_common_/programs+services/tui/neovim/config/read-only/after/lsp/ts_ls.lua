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
