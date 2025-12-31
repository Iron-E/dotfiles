return {
	{
		"brenoprata10/nvim-highlight-colors",
		cmd = "HighlightColors",
		keys = { { "<Leader>C", "<Cmd>HighlightColors Toggle<CR>", mode = "n", desc = "Toggle colorizer" } },
		opts = function(_, o)
			o.enable_named_colors = true
			o.enable_tailwind = true
			o.render = "virtual"
		end,
	},
}
