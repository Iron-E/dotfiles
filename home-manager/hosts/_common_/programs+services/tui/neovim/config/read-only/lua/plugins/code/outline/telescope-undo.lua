return {{ 'debugloop/telescope-undo.nvim',
	config = function() require('telescope').load_extension 'undo' end,
	dependencies = 'telescope.nvim',
	keys = {{ '<A-w>u', '<Cmd>Telescope undo<CR>', desc = 'Telescope undo', mode = 'n' }},
}}
