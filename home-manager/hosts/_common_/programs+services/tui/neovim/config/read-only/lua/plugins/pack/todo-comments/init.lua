vim.keymap.set("n", "<A-w>T", "<Cmd>TodoQuickFix<CR>", {
	desc = "View todos in the quickfix window",
})

require("todo-comments").setup({
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
})
