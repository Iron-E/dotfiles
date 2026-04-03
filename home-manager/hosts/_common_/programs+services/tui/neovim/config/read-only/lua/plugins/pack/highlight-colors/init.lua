vim.keymap.set("n", "<Leader>C", "<Cmd>HighlightColors Toggle<CR>", {
	desc = "Toggle colorizer",
})

require("nvim-highlight-colors").setup({
	enable_named_colors = true,
	enable_tailwind = true,
	render = "virtual",
})
