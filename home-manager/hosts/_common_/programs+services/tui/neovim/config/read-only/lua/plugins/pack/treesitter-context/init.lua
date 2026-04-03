vim.keymap.set("n", "<A-w>c", "<Cmd>TSContext toggle<CR>", {
	desc = "Toggle TS context",
})

require("treesitter-context").setup({
	max_lines = 3,
})
