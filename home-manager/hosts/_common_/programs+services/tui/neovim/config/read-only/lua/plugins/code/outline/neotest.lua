return {{ 'nvim-neotest/neotest',
	dependencies = {
		-- pre-reqs
		'antoinemadec/FixCursorHold.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-neotest/nvim-nio',
		'nvim-treesitter/nvim-treesitter',

		-- adapters
		'Issafalcon/neotest-dotnet',
		'marilari88/neotest-vitest',
		'nvim-neotest/neotest-go',
	},
	cmd = 'Neotest',
	keys = {{ '<A-w>t', '<Cmd>Neotest summary<CR>', desc = 'Open test panel', mode = 'n' }},
	opts = function(_, o)
		o.loglevel = vim.log.levels.OFF
		o.adapters = {
			require 'neotest-dotnet',
			require 'neotest-go',
			require 'neotest-vitest',
		}
	end,
}}
