--- @type vim.lsp.Config
return {
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "renovate.json", ".renovaterc", ".renovaterc.json" },
					url = "https://docs.renovatebot.com/renovate-schema.json",
				},
				{
					fileMatch = { "deno.json", "deno.jsonc" },
					url = "https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json",
				},
			},
		},
	},
}
