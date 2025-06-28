--- @module 'lazy'

--- @type LazySpec[]
return {{ 'stevearc/dressing.nvim',
	lazy = true,
	init = function(dressing)
		--- @diagnostic disable-next-line:duplicate-set-field
		vim.ui.input = function(...)
			require('lazy.core.loader').load(dressing, { cmd = 'Lazy load' })
			vim.ui.input(...)
		end
	end,
	opts = function(_, o)
		o.select = { enabled = false }
	end,
}}
