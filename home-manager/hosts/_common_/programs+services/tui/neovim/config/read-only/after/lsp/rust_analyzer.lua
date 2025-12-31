--- @type vim.lsp.Config
return {
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				extraArgs = {
					"--target-dir",
					"/tmp/rust-analyzer-check",
				},
			},
			diagnostics = {
				disabled = {
					"inactive-code",
				},
			},
		},
	},
}
