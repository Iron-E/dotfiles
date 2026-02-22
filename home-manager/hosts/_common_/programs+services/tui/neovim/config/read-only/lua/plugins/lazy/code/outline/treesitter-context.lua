return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = "TSContextToggle",
		dependencies = "nvim-treesitter",
		event = vim.g.lazy_event_file_read,
		keys = { { "<A-w>c", "<Cmd>TSContext toggle<CR>", desc = "Toggle TS context", mode = "n" } },
		opts = function(_, o)
			o.max_lines = 3
		end,
	},
}
