local opts = { scope = 'local' }

vim.api.nvim_set_option_value('commentstring', '// %s', opts)
vim.api.nvim_set_option_value('makeprg', 'gleam', opts)
