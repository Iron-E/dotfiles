vim.api.nvim_command("packadd nvim.undotree")

vim.api.nvim_set_keymap("n", "<A-w>u", "<Cmd>Undotree<CR>", { noremap = true })
