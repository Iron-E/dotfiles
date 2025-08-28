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
---@param winid? integer
---@param bufnr? integer
local function ts_win_enable(winid, bufnr)
	if winid == nil then
		winid = vim.api.nvim_get_current_win()
	end

	if bufnr == nil then
		bufnr = vim.api.nvim_win_get_buf(winid)
	end

	local ok = pcall(vim.treesitter.start, bufnr)
	if not ok then -- could not start treesitter
		return
	end

	-- use treesitter for folds
	vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.treesitter.foldexpr()', { win = winid })
end

vim.api.nvim_create_user_command(
	'TSWinEnable',
	function(args)
		for i, v in ipairs(args) do
			args[i] = tonumber(v)
		end

		ts_win_enable(unpack(args))
	end,
	{
		desc = 'Try to enable treesitter highlighting for a buffer.',
		nargs = '+',
	}
)

vim.api.nvim_create_autocmd('FileType', {
	desc = 'Start treesitter for buffer',
	group = 'config',
	callback = vim.schedule_wrap(function(ev)
		ts_win_enable(vim.api.nvim_get_current_win(), ev.buf)
	end),
})
