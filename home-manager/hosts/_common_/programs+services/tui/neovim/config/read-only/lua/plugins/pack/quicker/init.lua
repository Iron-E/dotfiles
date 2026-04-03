--- @type quicker.SetupOptions
local opts = {
	opts = {
		number = vim.api.nvim_get_option_value("number", {}),
		relativenumber = vim.api.nvim_get_option_value("relativenumber", {}),
	},

	keys = {
		{ "za", '<Cmd>lua require("quicker").toggle_expand()<CR>', desc = "Collapse quickfix content" },
		{ "zm", '<Cmd>lua require("quicker").expand()<CR>', desc = "Expand quickfix content" },
		{ "zn", '<Cmd>lua require("quicker").refresh()<CR>', desc = "Refresh the quickfix window" },
		{ "zr", '<Cmd>lua require("quicker").collapse()<CR>', desc = "Collapse quickfix content" },
	},
}

local diagnostic_signs = vim.diagnostic.config().signs --- @type vim.diagnostic.Opts.Signs
local diagnostic_text = diagnostic_signs.text
if diagnostic_text ~= nil then
	opts.type_icons = {
		E = diagnostic_text[vim.diagnostic.severity.ERROR],
		H = diagnostic_text[vim.diagnostic.severity.HINT],
		I = diagnostic_text[vim.diagnostic.severity.INFO],
		N = diagnostic_text[vim.diagnostic.severity.HINT],
		W = diagnostic_text[vim.diagnostic.severity.WARN],
	}
end

require("quicker").setup(opts)
