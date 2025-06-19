-- HACK: see https://github.com/neovim/neovim/issues/33577
vim.lsp.config('emmet_language_server', {
	filetypes = {
		'cs',
		'css',
		'eruby',
		'html',
		'htmlangular',
		'htmldjango',
		'javascriptreact',
		'less',
		'pug',
		'sass',
		'scss',
		'typescriptreact',
		'xml',
	},
})

--- @type vim.lsp.Config
return {
	init_options = {
		includeLanugages = { cs = 'xml' },
		showAbbreviationSuggestions = true,
		showExpandedAbbreviation = true,
		showSuggestionsAsSnippets = true,
		syntaxProfiles = { html = 'xhtml' },
	},
}
