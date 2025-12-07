-- denols renders code fences with ```ts
do
	local var = 'markdown_fenced_languaged'
	local fenced_languages = vim.g[var] or {}
	table.insert(fenced_languages, 'ts=typescript')
	vim.api.nvim_set_var(var, fenced_languages)
end

--- @type vim.lsp.Config
return {
	-- NOTE: used to prevent denols and ts_ls from spawning in same process
	root_markers = { 'deno.json', 'deno.jsonc' },

	workspace_required = true,
}
