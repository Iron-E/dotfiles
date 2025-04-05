--- @module 'mini.trailspace'

return {{ 'echasnovski/mini.trailspace', opts = function()
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = 'config',
		callback = function(ev)
			local opts = { buf = ev.buf }
			if not vim.api.nvim_get_option_value('binary', opts) and
				vim.api.nvim_get_option_value('filetype', opts) ~= 'diff'
			then
				MiniTrailspace.trim_last_lines()
			end
		end,
	})
end}}
