--- @type vim.lsp.Config
return {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticSeverityOverrides = {
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
}
