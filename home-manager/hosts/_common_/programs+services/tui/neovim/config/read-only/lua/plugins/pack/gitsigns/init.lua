vim.api.nvim_set_keymap("n", "[h", "<Cmd>Gitsigns prev_hunk<CR>", {
	desc = "Previous hunk",
})

vim.api.nvim_set_keymap("n", "]h", "<Cmd>Gitsigns next_hunk<CR>", {
	desc = "Next hunk",
})

vim.api.nvim_set_keymap("n", "<A-w>C", "<Cmd>Gitsigns setqflist<CR>", {
	desc = "Next hunk",
})

vim.api.nvim_set_keymap("n", "<A-w><A-c>", "<Cmd>Gitsigns setloclist<CR>", {
	desc = "Next hunk",
})

vim.keymap.set({ "n", "x" }, "<Leader>hs", "<Cmd>Gitsigns stage_hunk<CR>", {
	desc = "Stage hunk",
})

vim.api.nvim_set_keymap("n", "<Leader>hu", "<Cmd>Gitsigns undo_stage_hunk<CR>", {
	desc = "Unstage hunk",
})

vim.api.nvim_set_keymap("n", "<A-w>b", "<Cmd>Gitsigns blame<CR>", {
	desc = "Toggle git blame in split",
})

vim.api.nvim_set_keymap("n", "<A-w>B", "<Cmd>Gitsigns blame_line<CR>", {
	desc = "Toggle git blame as virtual text",
})

require("gitsigns").setup({
	preview_config = {
		border = vim.api.nvim_get_option_value("winborder", {}),
	},

	trouble = false,
})
