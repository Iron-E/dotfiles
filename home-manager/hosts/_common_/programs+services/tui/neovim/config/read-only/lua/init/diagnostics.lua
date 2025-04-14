--- @type vim.diagnostic.Opts.Signs
local signs = { text = { ' ', ' ', ' ', ' ' } }

--- @type vim.diagnostic.Opts
local diagnostic_config = {
	severity_sort = true,
	signs = signs,
	virtual_text = {
		prefix = function(diagnostic)
			return signs.text[diagnostic.severity]
		end,
		source = 'if_many',
		spacing = 1,
	},
}

vim.diagnostic.config(diagnostic_config)
