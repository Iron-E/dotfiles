-- denols renders code fences with ```ts
do
	local var = 'markdown_fenced_languaged'
	local fenced_languages = vim.g[var] or {}
	table.insert(fenced_languages, 'ts=typescript')
	vim.api.nvim_set_var(var, fenced_languages)
end

--- @type vim.lsp.Config
return {}
