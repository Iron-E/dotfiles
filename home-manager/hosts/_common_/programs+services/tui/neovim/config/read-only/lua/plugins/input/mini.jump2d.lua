return {{ 'echasnovski/mini.jump2d', opts = {
	keys = {{'<Space>', desc = 'jump2d'}},
	opts = function(_, o)
		o.mappings = { start_jumping = '<Space>' }
	end,
}}}
