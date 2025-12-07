--- @type vim.lsp.Config
return {
	init_options =
	{
		jvm_args = {
			['java.format.settings.url'] = vim.fn.stdpath('config')..'/eclipse-formatter.xml',
		},
	},
}
