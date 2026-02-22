return {
	{
		"tversteeg/registers.nvim",
		keys = {
			{ '"', desc = "View the registers", mode = { "n", "x" } },
			{ "<C-r>", desc = "View the registers", mode = "i" },
		},
		opts = function(_, o)
			o.window = { border = vim.o.winborder }
		end,
	},
}
