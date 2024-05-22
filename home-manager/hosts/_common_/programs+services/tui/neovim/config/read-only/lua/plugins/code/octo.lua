return {{ 'pwntester/octo.nvim',
	cmd = 'Octo',
	keys = {{ '<A-w>o', '<Cmd>Octo<CR>', desc = 'octo.nvim fuzy find', mode = 'n' }},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	opts = function(_, o)
		o.default_merge_method = 'squash'
		o.enable_builtin = true
		o.use_local_fs = true

		vim.treesitter.language.register('markdown', 'octo')
	end,
}}
