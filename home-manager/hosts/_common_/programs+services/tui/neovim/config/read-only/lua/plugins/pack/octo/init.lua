vim.api.nvim_set_keymap("n", "<A-w>o", "<Cmd>Octo<CR>", { desc = "octo.nvim fuzy find" })

require("octo").setup({
	default_merge_method = "merge",
	enable_builtin = true,
	picker = "fzf-lua",
	use_local_fs = true,
})

vim.treesitter.language.register("markdown", "octo")
