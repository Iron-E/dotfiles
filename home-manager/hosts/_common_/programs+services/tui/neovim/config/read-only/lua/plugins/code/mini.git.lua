return {{ 'echasnovski/mini-git',
	keys = {{
		'<Leader>K',
		'<Cmd>lua MiniGit.show_at_cursor()<CR>',
		mode = { 's', 'v' },
		desc = 'Show Git info at cursor',
	}},
	config = function()
		vim.api.nvim_create_autocmd('FileType', {
			command = 'setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr()',
			pattern = { 'diff', 'git' },
			group = 'config',
		})
	end,
}}
