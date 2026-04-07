require("mini.sessions").setup({
	-- Whether to read default session if Neovim opened without file arguments
	autoread = false,

	-- Whether to write currently read session before leaving it
	autowrite = true,

	-- Directory where global sessions are stored (use `''` to disable)
	directory = vim.fn.stdpath("data") .. "/mini.sessions",

	-- File for local session (use `''` to disable)
	file = ".session.vim",

	-- Whether to force possibly harmful actions (meaning depends on function)
	force = {
		read = false,
		write = true,
		delete = false,
	},

	hooks = {
		pre = {
			write = function()
				vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
			end,
		},
	},

	verbose = {
		read = false,
		write = true,
		delete = true,
	},
})

vim.api.nvim_create_user_command("Restart", "lua MiniSessions.restart()", {
	desc = "Restart neovim and preserve current session.",
})

vim.api.nvim_create_user_command("Session", function(args)
	--- @type nil|string
	local action
	if args.args ~= "" then
		action = args.args
	end

	MiniSessions.select(action)
end, {
	desc = "Manage sessions via mini.sessions",
	nargs = "?",
	complete = function()
		return { "read", "delete", "write" }
	end,
})

vim.api.nvim_set_keymap("n", "<A-s>", ":<C-u>Session ", {
	desc = "Manage sessions via mini.sessions",
	noremap = true,
})
