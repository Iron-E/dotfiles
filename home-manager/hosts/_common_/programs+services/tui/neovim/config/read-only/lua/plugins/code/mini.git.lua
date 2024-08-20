return {{ 'echasnovski/mini-git',
	cmd = 'Git',
	config = true,
	keys = {{ '<Leader>K', '<Cmd>lua MiniGit.show_at_cursor()<CR>', mode = 'v', desc = 'Show Git info at cursor' }},
	main = 'mini.git',
	opts = function()
		vim.api.nvim_create_autocmd('FileType', {
			command = 'setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr()',
			pattern = { 'diff', 'git' },
			group = 'config',
		})
	end,
}}
