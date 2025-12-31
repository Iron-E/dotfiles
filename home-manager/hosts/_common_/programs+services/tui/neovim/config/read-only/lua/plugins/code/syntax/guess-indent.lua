return {{ 'NMAC427/guess-indent.nvim',
	cmd = 'GuessIndent',
	opts = function(_, o)
		o.auto_cmd = false
		o.override_editorconfig = true
	end,
}}
