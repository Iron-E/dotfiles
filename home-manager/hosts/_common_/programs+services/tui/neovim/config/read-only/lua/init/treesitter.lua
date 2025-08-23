------------
-- config --
------------

vim.treesitter.language.register('bash', { 'env', 'zsh' })
vim.treesitter.language.register('gitignore', { 'dockerignore', 'helmignore' })

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
---@param bufnr integer
---@param winid integer
local function ts_buf_enable(bufnr, winid)
	if not pcall(vim.treesitter.start, bufnr) then
	end

	-- use treesitter for folds
	vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.treesitter.foldexpr()', { win = winid })
end

vim.api.nvim_create_user_command(
	'TSBufEnable',
	function(args)
		local bufnr = tonumber(args.fargs[1])
		local winid = tonumber(args.fargs[3])

		ts_buf_enable(bufnr, winid)
	end,
	{
		desc = 'Try to enable treesitter highlighting for a buffer.',
		nargs = '+',
	}
)

vim.api.nvim_create_autocmd('FileType', {
	desc = 'Start treesitter for buffer',
	group = 'config',
	callback = function(ev)
		ts_buf_enable(ev.buf, vim.api.nvim_get_current_win())
	end,
})
