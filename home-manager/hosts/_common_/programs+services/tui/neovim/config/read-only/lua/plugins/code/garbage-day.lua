return {{ 'Zeioth/garbage-day.nvim',
	cond = vim.g.man ~= true,
	dependencies = "neovim/nvim-lspconfig",
	event = vim.g.lazy_read_file_event,
	opts = function(_, o)
		o.grace_period = 60 * 5 -- in seconds
		o.wakeup_delay = 1000 -- in milliseconds
	end,
}}
