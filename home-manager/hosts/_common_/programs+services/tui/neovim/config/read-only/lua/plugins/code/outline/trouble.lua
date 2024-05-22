return {{ 'folke/trouble.nvim',
	dependencies = 'nvim-web-devicons',
	cond = vim.g.man ~= true,
	keys =
	{
		{ '<A-w>d', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Toggle trouble.nvim workspace diagnostics', mode = 'n' },
		{']D',
			function() require('trouble').next { skip_groups = true, jump = true } end,
			desc = 'Jump to the next Trouble entry',
			mode = 'n',
		},
		{'[D',
			function() require('trouble').previous { skip_groups = true, jump = true } end,
			desc = 'Jump to the previous Trouble entry',
			mode = 'n',
		},
		{ '<A-w>T', '<Cmd>TodoTrouble<CR>', desc = 'Toggle trouble.nvim todos using todo-comments.nvim', mode = 'n' },
	},
	opts = function(_, o)
		o.auto_preview = false
	end,
}}
