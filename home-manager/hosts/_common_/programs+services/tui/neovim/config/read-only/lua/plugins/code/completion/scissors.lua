return {{ 'chrisgrieser/nvim-scissors',
	dependencies = 'nvim-telescope/telescope.nvim',
	keys = {
		{'<A-w>s', function() require('scissors').addNewSnippet() end, desc = 'Add snippet with scissors', mode = {'n', 'x'}},
		{'<A-w>S', function() require('scissors').editSnippet() end, desc = 'Edit snippet with scissors', mode = 'n'},
	},
	config = function(_, o)
		require('scissors').setup(o)
		require('scissors.config').config.telescope.opts.layout_config.preview_width = nil
	end,
	opts = function(_, o)
		o.jsonFormatter = { 'jq', '--monochrome-output', '--sort-keys', '--tab' }
		o.editSnippetPopup = {
			height = 0.85, -- relative to the window, number between 0 and 1
			width = 0.8,
			keymaps = {
				deleteSnippet = '<Leader>d',
				duplicateSnippet = '<Leader>r',
			}
		}
	end,
}}
