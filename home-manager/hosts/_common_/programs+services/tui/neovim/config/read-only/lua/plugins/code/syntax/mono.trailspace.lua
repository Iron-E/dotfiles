return {{ 'echasnovski/mini.trailspace', opts = function()
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = 'config',
		callback = function(ev)
			local buf = ev.buf
			if not vim.api.nvim_get_option_value('binary', {buf = buf}) and
				vim.api.nvim_get_option_value('filetype', {buf = buf}) ~= 'diff'
			then
				MiniTrailspace.trim_last_lines()
			end
		end,
	})
end}}
