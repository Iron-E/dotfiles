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
---@param bufnr integer
---@param winid integer
local function ts_buf_enable(bufnr, winid)
	local ok = pcall(vim.treesitter.start, bufnr)
	if not ok then -- failed to start
		return
	end

	-- disable legacy syntax highlighting
	vim.api.nvim_set_option_value('syntax', 'OFF', { buf = bufnr })

	-- use treesitter for folds
	vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.treesitter.foldexpr()', { win = winid })
end

vim.api.nvim_create_user_command(
	'TSBufEnable',
	function(args)
		local fargs = args.fargs

		local bufnr = 0
		local winid = 0
		if #fargs > 0 then
			bufnr = tonumber(fargs[1])

			if #fargs > 1 then
				winid = tonumber(fargs[2])
			end
		end

		ts_buf_enable(bufnr, winid)
	end,
	{
		desc = 'Try to enable treesitter highlighting for a buffer.',
		nargs = '*',
	}
)

vim.api.nvim_create_autocmd('FileType', {
	desc = 'Start treesitter for buffer',
	group = 'config',
	callback = function(ev)
		local win = vim.api.nvim_get_current_win()
		ts_buf_enable(ev.buf, win)
	end,
})
