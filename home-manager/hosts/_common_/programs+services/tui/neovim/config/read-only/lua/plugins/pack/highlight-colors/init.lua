vim.keymap.set("n", "<Leader>C", "<Cmd>HighlightColors Toggle<CR>", {
	desc = "Toggle colorizer",
})

require("nvim-highlight-colors").setup({
	enable_named_colors = true,
	enable_tailwind = true,
	render = "virtual",

	exclude_buffer = function(bufnr)
		-- TODO: should this be for all the clients on a buffer?
		return vim.lsp.document_color.is_enabled({ bufnr = bufnr })
	end,
})
