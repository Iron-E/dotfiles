-- HACK: see https://github.com/neovim/neovim/issues/33577
vim.lsp.config('bashls', {
	filetypes = {
		'sh',
		'zsh',
	},
})

--- @type vim.lsp.Config
return {}
