--- @module 'lazy'
--- @module 'flash'

--- @type LazySpec[]
return {
	{
		"folke/flash.nvim",

		keys = {
			{ "F", mode = { "n", "x", "o" }, desc = "flash backward" },
			{ "f", mode = { "n", "x", "o" }, desc = "flash forward" },
			{ "T", mode = { "n", "x", "o" }, desc = "flash backward till" },
			{ "t", mode = { "n", "x", "o" }, desc = "flash forward till" },
			{ ";", mode = { "n", "x", "o" }, desc = "repeat last f/F/t/T" },
			{ ",", mode = { "n", "x", "o" }, desc = "repeat last f/F/t/T backwards" },
			{
				"<Space>",
				mode = { "n", "x", "o" },
				'<Cmd>lua require("flash").jump()<CR>',
				desc = "Flash",
			},
			{
				"<C-Space>",
				mode = { "n", "x", "o" },
				'<Cmd>lua require("flash").treesitter()<CR>',
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				'<Cmd>lua require("flash").remote()<CR>',
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				'<Cmd>lua require("flash").treesitter_search()<CR>',
				desc = "Flash Treesitter Search",
			},
			{
				"<C-s>",
				mode = { "c" },
				'<Cmd>lua require("flash").toggle()<CR>',
				desc = "Toggle Flash Search",
			},
		},

		config = true,

		--- @param o Flash.Config
		opts = function(_, o)
			o.modes = {
				char = {
					highlight = {
						backdrop = false,
					},

					--- @param _ 'f'|'F'|'t'|'T' the motion
					char_actions = function(_)
						return {
							[";"] = "right", -- default "next"
							[","] = "left", -- default "prev"

							-- -- jump2d style: same case goes next, opposite case goes prev
							-- [motion] = "next",
							-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
						}
					end,
				},

				treesitter = {
					actions = {
						[";"] = "next",
						[","] = "prev",
					},

					highlight = {
						backdrop = true,
					},
				},
			}
		end,
	},
}
