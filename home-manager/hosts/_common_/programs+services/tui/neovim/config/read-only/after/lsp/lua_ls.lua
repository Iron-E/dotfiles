--- @type vim.lsp.Config
return {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
			hint = {
				enable = true,
			},
			runtime = {
				path = vim.split(package.path, ";", { plain = true, trimempty = true }),
				pathStrict = true,
				version = "LuaJIT",
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
