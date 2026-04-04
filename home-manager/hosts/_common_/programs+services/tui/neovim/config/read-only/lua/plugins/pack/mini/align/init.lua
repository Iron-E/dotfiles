--- the options to use when aligning a markdown table
local align_markdown_table = "tm<Space><CR>s<Bar><CR>"

require("mini.align").setup({
	mappings = {
		start = "<Leader>a",
		start_with_preview = "<Leader>A",
	},
})

local group = vim.api.nvim_create_augroup("config.heirline", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "Setup buffer specific mappings",
	group = group,
	callback = function()
		vim.api.nvim_set_keymap("n", "<Leader>t", "<Leader>aip" .. align_markdown_table, {
			silent = true,
			desc = "Align markdown table in paragraph",
		})

		vim.api.nvim_set_keymap("x", "<Leader>t", "<Leader>a" .. align_markdown_table, {
			silent = true,
			desc = "Align selected markdown table",
		})
	end,
})
