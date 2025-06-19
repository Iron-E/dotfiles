--- @type vim.lsp.Config
return {
	cmd = { 'vscode-json-languageserver', '--stdio' },
	settings = {
		json = {
			schemas = {
				fileMatch = { "deno.json", "deno.jsonc" },
				url = "https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json",
			},
		},
	},
}
