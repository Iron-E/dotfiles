--- @module 'lazy'

--- @type LazySpec[]
return {
	{
		"echasnovski/mini.jump2d",
		cond = false,
		keys = { { "<Space>", desc = "jump2d" } },
		opts = function(_, o)
			o.mappings = { start_jumping = "<Space>" }
		end,
	},
}
