--- @module 'guess-indent'

return {{ 'NMAC427/guess-indent.nvim',
	cmd = 'GuessIndent',

	--- @param o GuessIndentConfig
	opts = function(_, o)
		o.auto_cmd = false
		o.override_editorconfig = true
		o.on_space_options = {
			expandtab = true,
			tabstop = "detected",
			shiftwidth = 0,
			softtabstop = -1,
		}
	end,
}}
