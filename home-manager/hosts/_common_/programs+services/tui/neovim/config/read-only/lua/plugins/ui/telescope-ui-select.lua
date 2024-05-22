return {{ 'nvim-telescope/telescope-ui-select.nvim',
	dependencies = 'telescope.nvim',
	lazy = true,
	init = function()
		--- Lazy loads telescope on first run
		--- @diagnostic disable-next-line:duplicate-set-field
		function vim.ui.select(...)
			require('telescope').load_extension 'ui-select'
			vim.ui.select(...)
		end
	end,
}}
