-- NOTE: replace these syntax files with treesitter parsers when available
return {
	{ 'aklt/plantuml-syntax',
		ft = 'plantuml',
		config = function()
			vim.api.nvim_set_var('plantuml_executable_script', '/usr/bin/plantuml')
		end,
	},
	{ 'mboughaba/i3config.vim', ft = 'i3config' },
	{ 'MTDL9/vim-log-highlighting', ft = 'log' },
	{ 'chaimleib/vim-renpy',
		ft = 'renpy',
		config = function()
			vim.api.nvim_set_hl(0, 'pythonAttribute', {link = '@variable.member.python'});
			vim.api.nvim_set_hl(0, 'pythonBuiltin', {link = '@variable.builtin.python'});
			vim.api.nvim_set_hl(0, 'pythonFunction', {link = '@lsp.type.class.python'});
			vim.api.nvim_set_hl(0, 'pythonDecorator', {link = '@punctuation.special.python'});
			vim.api.nvim_set_hl(0, 'pythonDecoratorName', {link = '@attribute.python'});
			vim.api.nvim_set_hl(0, 'pythonStatement', {link = '@keyword.python'});
			vim.api.nvim_set_hl(0, 'renpyBuiltin', {link = '@keyword.renpy'});
			vim.api.nvim_set_hl(0, 'renpyEscape', {link = '@string.escape'});
			vim.api.nvim_set_hl(0, 'renpyFunction', {link = '@lsp.type.class.renpy'});
			vim.api.nvim_set_hl(0, 'renpyHeader', {link = '@punctuation.delimiter'});
			vim.api.nvim_set_hl(0, 'renpyHeaderArgs', {link = '@punctuation.delimiter'});
			vim.api.nvim_set_hl(0, 'renpyHeaderFById', {link = '@type.renpy'});
			vim.api.nvim_set_hl(0, 'renpyHeaderFByPriority', {link = '@keyword.renpy'});
			vim.api.nvim_set_hl(0, 'renpyHeaderIdentifier', {link = '@function.renpy'});
			vim.api.nvim_set_hl(0, 'renpyHeaderPython', {link = '@keyword.renpy'});
			vim.api.nvim_set_hl(0, 'renpyStatement', {link = '@keyword.renpy'});
		end,
	},
}
