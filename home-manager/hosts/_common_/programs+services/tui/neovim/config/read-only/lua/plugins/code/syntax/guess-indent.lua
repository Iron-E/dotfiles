return {{ 'NMAC427/guess-indent.nvim',
	event = 'BufReadPre',
	opts = function(_, o)
		o.auto_cmd = true
		o.override_editorconfig = false
	end,
}}
