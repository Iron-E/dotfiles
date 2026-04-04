vim.keymap.set({ "n", "x" }, "<Leader>K", "<Cmd>lua MiniGit.show_at_cursor()<CR>", {
	desc = "Show Git info at cursor",
})

require("mini.git").setup()

local group = vim.api.nvim_create_augroup("config.mini.git", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "set foldexpr",
	group = group,
	pattern = { "diff", "git" },
	command = [[setlocal foldmethod=expr foldexpr=v:lua.require('mini.git').diff_foldexpr()]],
})
