-- HACK: see https://github.com/neovim/neovim/issues/33577
vim.lsp.config('tofu_ls', {
	filetypes = {
		'opentofu',
		'opentofu-vars',
	},
})

--- @type vim.lsp.Config
return {}
