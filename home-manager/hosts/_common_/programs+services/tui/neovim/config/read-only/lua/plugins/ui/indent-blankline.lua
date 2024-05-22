return {{ 'lukas-reineke/indent-blankline.nvim',
	cond = vim.g.man ~= true,
	main = 'ibl',
	opts = {
		indent = { char = '│' },
		scope = { enabled = false },
	},
}}
