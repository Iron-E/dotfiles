return {{ 'folke/trouble.nvim',
	dependencies = 'nvim-web-devicons',
	cond = vim.g.man ~= true,
	keys =
	{
		{ '<A-w>d', '<Cmd>Trouble diagnostics toggle<CR>', desc = 'Toggle trouble.nvim workspace diagnostics', mode = 'n' },
		{']D',
			function() require('trouble').next() end,
			desc = 'Jump to the next Trouble entry',
			mode = 'n',
		},
		{'[D',
			function() require('trouble').prev() end,
			desc = 'Jump to the previous Trouble entry',
			mode = 'n',
		},
		{ '<A-w>T', '<Cmd>Trouble todo toggle<CR>', desc = 'Toggle trouble.nvim todos using todo-comments.nvim', mode = 'n' },
	},
	opts = function(_, o)
		o.auto_preview = false
	end,
}}
