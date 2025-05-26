------------
-- config --
------------

vim.treesitter.language.register('bash', { 'env', 'zsh' })
vim.treesitter.language.register('gitignore', 'dockerignore')

--------------
-- mappings --
--------------

-- Highlighting inspect
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>Inspect<CR>', {})

-- Syntax tree inspect
vim.api.nvim_set_keymap('n', '<F11>', '', { callback = function()
	local winnr = vim.api.nvim_get_current_win()
	local cursor = vim.api.nvim_win_get_cursor(winnr)

	vim.api.nvim_command 'InspectTree'
	local inspect_winnr = vim.api.nvim_get_current_win()

	vim.api.nvim_set_current_win(winnr)
	vim.api.nvim_win_set_cursor(winnr, cursor)
	vim.api.nvim_set_current_win(inspect_winnr)
end })

------------
-- enable --
------------

--- Enable treesitter for the current buffer.
local function ts_buf_enable()
	local ok = pcall(vim.treesitter.start)
	if not ok then -- failed to start
		return
	end

	--- @type vim.api.keyset.option
	local opts = { scope = 'local' }

	-- disable legacy syntax highlighting
	vim.api.nvim_set_option_value('syntax', 'OFF', opts)

	-- use treesitter for folds
	vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.treesitter.foldexpr()', opts)
end

vim.api.nvim_create_user_command(
	'TSBufEnable',
	ts_buf_enable,
	{ desc = 'Try to enable treesitter highlighting for a buffer.' }
)

vim.api.nvim_create_autocmd('FileType', {
	desc = 'Start treesitter for buffer',
	group = 'config',
	callback = ts_buf_enable,
})
