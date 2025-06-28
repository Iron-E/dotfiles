return {{ 'pwntester/octo.nvim',
	cmd = 'Octo',

	keys = {{
		'<A-w>o',
		'<Cmd>Octo<CR>',
		desc = 'octo.nvim fuzy find',
		mode = 'n',
	}},

	dependencies = {
		'nvim-lua/plenary.nvim',
		'ibhagwan/fzf-lua',
		'echasnovski/mini.icons',
	},

	opts = function(_, o)
		o.default_merge_method = 'squash'
		o.enable_builtin = true
		o.use_local_fs = true

		vim.treesitter.language.register('markdown', 'octo')
	end,
}}
