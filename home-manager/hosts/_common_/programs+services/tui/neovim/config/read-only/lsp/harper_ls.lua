--- @type vim.lsp.Config
return {
	settings = {
		['harper-ls'] = {
			linters = {
				expand_time_shorthands = false,
				ExpandTimeShorthands = false,
				sentence_capitalization = false,
				SentenceCapitalization = false,
				Spaces = false,
				spaces = false,
				spell_check = false,
				SpellCheck = false,
			},
		},
	}
}
