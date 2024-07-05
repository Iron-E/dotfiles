--- mode for mapping
local nx = { 'n', 'x' }

return {{ 'echasnovski/mini.operators',
	keys = {
		{ 'g=', mode = nx, desc = 'Evalute motion' },
		{ 'g==', mode = nx, desc = 'Evalute line' },
		{ 'gm', mode = nx, desc = 'Multiply motion' },
		{ 'gmm', mode = nx, desc = 'Multiply line' },
		{ 'go', mode = nx, desc = 'Sort motion' },
		{ 'goo', mode = nx, desc = 'Sort line' },
		{ 'gp', mode = nx, desc = 'Replace motion' },
		{ 'gpp', mode = nx, desc = 'Replace line' },
		{ 'gs', mode = nx, desc = 'Exchange motion' },
		{ 'gss', mode = nx, desc = 'Exchange line' },
	},
	opts = function(_, o)
		o.evaluate = { prefix = 'g=' }
		o.exchange = { prefix = 'gs' }
		o.multiply = { prefix = 'gm' }
		o.replace = { prefix = 'gp' }
		o.sort = { prefix = 'go' }
	end,
}}
