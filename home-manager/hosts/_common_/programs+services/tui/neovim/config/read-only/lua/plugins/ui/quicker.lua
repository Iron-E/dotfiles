return {
	{
		"stevearc/quicker.nvim",
		ft = "qf",
		opts = function(_, o) --- @param o quicker.SetupOptions
			o.opts = {
				number = vim.api.nvim_get_option_value("number", {}),
				relativenumber = vim.api.nvim_get_option_value("relativenumber", {}),
			}

			o.keys = {
				{ "za", '<Cmd>lua require("quicker").toggle_expand()<CR>', desc = "Collapse quickfix content" },
				{ "zm", '<Cmd>lua require("quicker").expand()<CR>', desc = "Expand quickfix content" },
				{ "zn", '<Cmd>lua require("quicker").refresh()<CR>', desc = "Refresh the quickfix window" },
				{ "zr", '<Cmd>lua require("quicker").collapse()<CR>', desc = "Collapse quickfix content" },
			}

			local diagnostic_signs = vim.diagnostic.config().signs --- @type vim.diagnostic.Opts.Signs
			local diagnostic_text = diagnostic_signs.text
			if diagnostic_text ~= nil then
				o.type_icons = {
					E = diagnostic_text[vim.diagnostic.severity.E],
					H = diagnostic_text[vim.diagnostic.severity.HINT],
					I = diagnostic_text[vim.diagnostic.severity.I],
					N = diagnostic_text[vim.diagnostic.severity.N],
					W = diagnostic_text[vim.diagnostic.severity.W],
				}
			end
		end,
	},
}
