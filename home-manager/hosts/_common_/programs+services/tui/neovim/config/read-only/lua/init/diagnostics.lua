--- @type vim.diagnostic.Opts.Signs
local signs = { text = { " ", " ", " ", " " } }

--- @type vim.diagnostic.Opts
local diagnostic_config = {
	severity_sort = true,
	signs = signs,
	virtual_text = {
		prefix = function(diagnostic)
			return signs.text[diagnostic.severity]
		end,
		source = "if_many",
		spacing = 1,
	},
}

vim.diagnostic.config(diagnostic_config)

vim.api.nvim_set_keymap("n", "[d", "", {
	callback = function()
		vim.diagnostic.jump({ count = -1, float = true })
	end,
})

vim.api.nvim_set_keymap("n", "]d", "", {
	callback = function()
		vim.diagnostic.jump({ count = 1, float = true })
	end,
})

vim.api.nvim_set_keymap("n", "gC", "", {
	callback = function()
		vim.diagnostic.reset(nil, 0)
	end,
})

vim.api.nvim_set_keymap("n", "gK", "", { callback = vim.diagnostic.open_float })
vim.api.nvim_set_keymap("n", "<A-w>d", "", { callback = vim.diagnostic.setqflist })
vim.api.nvim_set_keymap("n", "<A-w><A-d>", "", { callback = vim.diagnostic.setloclist })
