local function set_omnifunc()
	vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lua_omnifunc', { buf = 0 })
end

set_omnifunc()
vim.api.nvim_create_autocmd('LspAttach', {
	callback = set_omnifunc,
	buffer = 0,
	once = true,
})
