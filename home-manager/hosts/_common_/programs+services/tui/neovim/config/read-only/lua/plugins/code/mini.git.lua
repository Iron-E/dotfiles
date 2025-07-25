return {{ 'echasnovski/mini-git',
	main = 'mini.git',

	cmd = 'Git',
	keys = {{
		'<Leader>K',
		'<Cmd>lua MiniGit.show_at_cursor()<CR>',
		mode = { 'n', 'v' },
		desc = 'Show Git info at cursor',
	}},

	init = function()
		vim.api.nvim_create_autocmd('FileType', {
			command = [[setlocal foldmethod=expr foldexpr=v:lua.require('mini.git').diff_foldexpr()]],
			pattern = { 'diff', 'git' },
			group = 'config',
		})
	end,

	config = true,
}}
