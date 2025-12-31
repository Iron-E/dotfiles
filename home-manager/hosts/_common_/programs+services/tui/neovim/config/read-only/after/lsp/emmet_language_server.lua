--- @type vim.lsp.Config
return {
	filetypes = {
		"cs",
		"css",
		"eruby",
		"html",
		"htmlangular",
		"htmldjango",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"typescriptreact",
		"xml",
	},

	init_options = {
		includeLanugages = { cs = "xml" },
		showAbbreviationSuggestions = true,
		showExpandedAbbreviation = true,
		showSuggestionsAsSnippets = true,
		syntaxProfiles = { html = "xhtml" },
	},
}
