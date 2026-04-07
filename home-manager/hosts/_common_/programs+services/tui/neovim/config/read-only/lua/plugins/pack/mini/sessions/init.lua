local local_session_name = ".session.vim"

require("mini.sessions").setup({
	-- Whether to read default session if Neovim opened without file arguments
	autoread = false,

	-- Whether to write currently read session before leaving it
	autowrite = true,

	-- Directory where global sessions are stored (use `''` to disable)
	directory = vim.fn.stdpath("data") .. "/mini.sessions",

	-- File for local session (use `''` to disable)
	file = local_session_name,

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

--- @param name string
--- @return nil|string
local function get_input_session_name(name)
	if name == "" then
		return
	end

	return name
end

--- @return string[]
local function get_session_names()
	local session_names = {}
	for _, v in pairs(MiniSessions.detected) do
		table.insert(session_names, v.name)
	end

	return session_names
end

vim.api.nvim_create_user_command("SessionWrite", function(args)
	MiniSessions.write(get_input_session_name(args.args))
end, {
	desc = "Write sessions via mini.sessions",
	nargs = "?",
	complete = function()
		local session_names = get_session_names()

		table.insert(session_names, 1, local_session_name)
		return vim.list.unique(session_names)
	end,
})

vim.api.nvim_create_user_command("SessionRead", function(args)
	MiniSessions.read(get_input_session_name(args.args))
end, {
	desc = "Read sessions via mini.sessions",
	nargs = "?",
	complete = get_session_names,
})

vim.api.nvim_create_user_command("SessionDelete", function(args)
	MiniSessions.delete(get_input_session_name(args.args))
end, {
	desc = "Delete sessions via mini.sessions",
	nargs = "?",
	complete = get_session_names,
})

vim.api.nvim_set_keymap("n", "<A-s>", ":<C-u>Session", {
	desc = "Manage sessions via mini.sessions",
	noremap = true,
})
