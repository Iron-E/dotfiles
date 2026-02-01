vim.api.nvim_buf_create_user_command(0, "New", function(args)
	--- @cast args vim.api.keyset.create_user_command.command_args

	return require("ftplugin.markdown.new").user_command_cb(args)
end, {
	desc = "Create a new markdown buffer with the given header.",
	nargs = "?",
})
