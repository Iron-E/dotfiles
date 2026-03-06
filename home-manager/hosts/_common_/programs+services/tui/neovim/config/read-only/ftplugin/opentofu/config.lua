vim.api.nvim_set_option_value("commentstring", "# %s", { scope = "local" })

-- HACK: I should disable smartindent, but have to look into replacement more
vim.api.nvim_buf_set_keymap(0, "i", "#", "<Space><BS>#", { noremap = true })
