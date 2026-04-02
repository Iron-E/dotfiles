--- @type vim.lsp.Config
return {
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			check = {
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
