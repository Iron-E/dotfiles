return {
	{
		"folke/todo-comments.nvim",
		cond = vim.g.man ~= true,
		dependencies = "nvim-lua/plenary.nvim",
		event = vim.g.lazy_event_file_read,
		keys = {
			{ "<A-w>T", "<Cmd>TodoQuickFix<CR>", desc = "View todos in the quickfix window", mode = "n" },
		},
		opts = {
			highlight = { comments_only = false, keyword = "bg" },
			merge_keywords = true,
			keywords = {
				FIX = { icon = "" },
				NOTE = { icon = "", alt = { "INFO", "SEE" } },
				PERF = { icon = "󰓅" },
				TEST = { icon = "" },
				TODO = { icon = "󰦕" },
				WARN = { icon = "", alt = { "SAFETY", "SEC" } },
			},
		},
	},
}
