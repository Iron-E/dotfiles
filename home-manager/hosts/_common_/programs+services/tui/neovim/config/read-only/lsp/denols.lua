-- denols renders code fences with ```ts
do
	local var = 'markdown_fenced_languaged'
	local fenced_languages = vim.g[var] or {}
	table.insert(fenced_languages, 'ts=typescript')
	vim.api.nvim_set_var(var, fenced_languages)
end

-- HACK: see https://github.com/neovim/neovim/issues/33577
vim.lsp.config('denols', {
	-- NOTE: used to prevent denols and ts_ls from spawning in same process
	root_markers = { 'deno.json', 'deno.jsonc' },
})

--- @type vim.lsp.Config
return {
	workspace_required = true,
}
