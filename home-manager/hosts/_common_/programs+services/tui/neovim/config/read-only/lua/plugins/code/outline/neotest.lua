return {{ 'nvim-neotest/neotest',
	dependencies = {
		'antoinemadec/FixCursorHold.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-neotest/nvim-nio',
		'nvim-treesitter/nvim-treesitter'
	},
	cmd = 'Neotest',
	keys = {{ '<A-w>t', '<Cmd>Neotest summary<CR>', desc = 'Open test panel', mode = 'n' }},
	opts = function(_, o)
		o.adapters = { require 'neotest-dotnet' }
		o.loglevel = vim.log.levels.OFF
	end,
}}
