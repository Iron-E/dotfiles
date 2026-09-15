vim.keymap.set("n", "<Leader>C", "<Cmd>HighlightColors Toggle<CR>", {
	desc = "Toggle colorizer",
})

require("nvim-highlight-colors").setup({
	enable_named_colors = true,
	enable_tailwind = true,
	render = "virtual",

	exclude_buffer = function(bufnr)
		local supports = false
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			if client:supports_method("textDocument/documentColor", bufnr) then
				supports = true
				break
			end
		end

		return supports and vim.lsp.document_color.is_enabled({ bufnr = bufnr })
	end,
})
