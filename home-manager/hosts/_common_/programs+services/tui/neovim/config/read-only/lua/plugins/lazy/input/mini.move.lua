--- mode for mapping
local nx = { "n", "x" }

return {
	{
		"echasnovski/mini.move",
		keys = {
			{ "gh", mode = nx, desc = "Move line left" },
			{ "gj", mode = nx, desc = "Move line down" },
			{ "gk", mode = nx, desc = "Move line up" },
			{ "gl", mode = nx, desc = "Move line right" },
		},
		opts = function(_, o)
			o.mappings = {
				down = "gj",
				left = "gh",
				right = "gl",
				up = "gk",
				line_down = "gj",
				line_left = "gh",
				line_right = "gl",
				line_up = "gk",
			}
		end,
	},
}
