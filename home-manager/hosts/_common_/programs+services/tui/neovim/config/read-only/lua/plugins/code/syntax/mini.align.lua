--- mode for mapping
local nx = { 'n', 'x' }

return {{ 'echasnovski/mini.align',
	keys = {
		{ '<Leader>a', mode = nx, desc = 'Align' },
		{ '<Leader>A', mode = nx, desc = 'Align with preview' },
	},
	opts = function(_, o)
		o.mappings = {
			start = '<Leader>a',
			start_with_preview = '<Leader>A',
		}
	end,
}}
