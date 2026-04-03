vim.api.nvim_set_keymap("n", "[b", ":BufferPrevious<CR>", {
	desc = "Go to the previous buffer",
})

vim.api.nvim_set_keymap("n", "[B", "<Cmd>BufferFirst<CR>", {
	desc = "Go to the first buffer",
})

vim.api.nvim_set_keymap("n", "]b", ":BufferNext<CR>", {
	desc = "Go to the next buffer",
})

vim.api.nvim_set_keymap("n", "]B", "<Cmd>BufferLast<CR>", {
	desc = "Go to the last buffer",
})

require("barbar").setup({
	animation = false,
	auto_hide = true,
	clickable = false,
	focus_on_close = "left",
	highlight_alternate = true,

	maximum_padding = math.huge,

	icons = {
		button = false,
		current = {
			diagnostics = { { enabled = false }, { enabled = false } },
			gitsigns = { added = { enabled = false }, changed = { enabled = false }, deleted = { enabled = false } },
		},
		diagnostics = { { enabled = true, icon = "" }, { enabled = true, icon = "" } },
		gitsigns = { added = { enabled = true }, changed = { enabled = true }, deleted = { enabled = true } },
		modified = { button = false },
		pinned = { button = "", filename = true },
		preset = "slanted",
	},
})
