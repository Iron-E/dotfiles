return {{ 'FabijanZulj/blame.nvim',
	cmd = 'BlameToggle',
	keys = {
		{ '<A-w>b', '<Cmd>BlameToggle window<CR>', desc = 'Toggle git blame in split', mode = 'n' },
		{ '<A-w>B', '<Cmd>BlameToggle virtual<CR>', desc = 'Toggle git blame as virtual text', mode = 'n' },
	},
	opts = function(_, o)
		o.date_format = "%Y-%m-%d"
	end,
}}
