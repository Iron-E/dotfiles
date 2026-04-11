vim.api.nvim_create_user_command("Winswitch", function(args)
	if args.bang == true then
		require("plugins.winswitch").switch_current()
	else
		require("plugins.winswitch").switch()
	end
end, {
	desc = "Switch the buffers attached to windows in-place",
	bang = true,
})

vim.api.nvim_set_keymap("n", "<Leader>w", "<Cmd>Winswitch!<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>W", "<Cmd>Winswitch<CR>", {})
