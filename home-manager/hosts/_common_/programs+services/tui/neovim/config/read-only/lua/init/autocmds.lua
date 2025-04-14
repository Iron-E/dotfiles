local augroup = vim.api.nvim_create_augroup('config', {clear = false})

--- Reset my indent guide settings
vim.api.nvim_create_autocmd({'BufWinEnter', 'BufWritePost', 'InsertLeave'},
{
	callback = function()
		vim.api.nvim_set_option_value('list', true, {})
		vim.opt.listchars = {nbsp = '␣', tab = '│ ', trail = '•'}
		vim.api.nvim_set_option_value('showbreak', '└ ', {})
	end,
	group = augroup,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
	callback = function() vim.lsp.codelens.refresh({ bufnr = 0 }) end,
	group = augroup,
})

--- Sync syntax when not editing text
vim.api.nvim_create_autocmd('CursorHold',
{
	callback = function(event)
		if vim.api.nvim_get_option_value('syntax', { buf = event.buf }) ~= '' then
			vim.api.nvim_command 'syntax sync fromstart'
		end

		if vim.lsp.semantic_tokens then
			vim.lsp.semantic_tokens.force_refresh(event.buf)
		end
	end,
	group = augroup,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
	callback = function(event)
		local buf = event.buf == 0 and vim.api.nvim_get_current_buf() or event.buf
		local win = vim.api.nvim_get_current_win()
		vim.defer_fn(function() -- because editorconfigs can change this setting
			if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_is_valid(win) then
				local textwidth = vim.api.nvim_get_option_value('textwidth', { buf = buf })
				vim.api.nvim_set_option_value('colorcolumn', tostring(textwidth), { win = win })
			end
		end, 100)
	end,
	group = augroup,
})

vim.api.nvim_create_autocmd({'FocusGained', 'VimResume'}, {command = 'checktime', group = augroup})

--- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost',
{
	callback = function() vim.highlight.on_yank() end,
	group = augroup,
})

if vim.fn.has 'wsl' == 1 then
	vim.api.nvim_create_autocmd('TextYankPost',
	{
		command = [[call system('clip.exe ',@")]],
		group = augroup,
	})
end
