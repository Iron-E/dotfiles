return {
	{
		"echasnovski/mini-git",
		main = "mini.git",

		cmd = "Git",
		keys = {
			{
				"<Leader>K",
				"<Cmd>lua MiniGit.show_at_cursor()<CR>",
				mode = { "n", "x" },
				desc = "Show Git info at cursor",
			},
		},

		init = function()
			local group = vim.api.nvim_create_augroup("config.mini.git", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				desc = "set foldexpr",
				group = group,
				pattern = { "diff", "git" },
				command = [[setlocal foldmethod=expr foldexpr=v:lua.require('mini.git').diff_foldexpr()]],
			})
		end,

		config = true,
	},
}
