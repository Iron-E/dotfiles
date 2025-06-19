-- HACK: see https://github.com/neovim/neovim/issues/33577
vim.lsp.config('terraformls', {
	filetypes = {
		'terraform',
		'terraform-vars',
		'tf',
	},
})

--- @type vim.lsp.Config
return {}
