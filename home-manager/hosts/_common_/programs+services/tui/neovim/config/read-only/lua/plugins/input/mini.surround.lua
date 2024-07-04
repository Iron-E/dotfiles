--- mode for mapping
local nx = { 'n', 'x' }

return {{ 'echasnovski/mini.surround',
	keys = {
		{ 'sa', mode = nx, desc = 'Surround add' },
		{ 'sd', mode = nx, desc = 'Surround delete' },
		{ 'sr', mode = nx, desc = 'Surround replace' },
		{ 'sf', mode = nx, desc = 'Surround find right' },
		{ 'sF', mode = nx, desc = 'Surround find left' },
		{ 'sh', mode = nx, desc = 'Surround highlight' },
		{ 'sn', mode = nx, desc = 'Surround config num_lines' },
	},
	opts = function(_, o)
		o.n_lines = 1000
	end,
}}
