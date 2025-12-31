return {
	{ "Iron-E/nvim-libmodal", lazy = true },
	{
		"Iron-E/nvim-bufmode",
		dependencies = "nvim-libmodal",
		keys = { { "<Leader>b", desc = "Enter bufmode", mode = "n" } },
		opts = function(_, o)
			o.barbar = true
		end,
	},
	{
		"Iron-E/nvim-tabmode",
		dependencies = "nvim-libmodal",
		keys = { { "<Leader><Tab>", desc = "Enter tabmode", mode = "n" } },
	},
}
