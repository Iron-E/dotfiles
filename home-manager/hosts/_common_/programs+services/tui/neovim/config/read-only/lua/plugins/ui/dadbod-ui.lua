return {{ 'kristijanhusak/vim-dadbod-ui',
	dependencies = 'tpope/vim-dadbod',
	keys = {{ '<A-w>D', '<Cmd>DBUIToggle<CR>', desc = 'Toggle the DBUI', mode = 'n' }},
	ft = { 'mysql', 'plsql', 'sql' },
	config = function()
		vim.api.nvim_set_var('db_ui_execute_on_save', false)
		vim.api.nvim_set_var('db_ui_save_location', vim.stdpath('data') .. '/db_ui')
		vim.api.nvim_set_var('db_ui_show_database_icon', true)
		vim.api.nvim_set_var('db_ui_use_nerd_fonts', true)

		vim.api.nvim_create_autocmd('FileType', {
			callback = function(event)
				vim.api.nvim_buf_set_keymap(event.buf, 'n', '<Leader>q', '<Plug>(DBUI_ExecuteQuery)', {})
				vim.api.nvim_buf_set_keymap(event.buf, 'n', '<Leader>S', '<Plug>(DBUI_SaveQuery)', {})
				vim.api.nvim_buf_set_keymap(event.buf, 'x', '<Leader>q', '<Plug>(DBUI_ExecuteQuery)', {})
			end,
			group = 'config',
			pattern = {'mysql', 'plsql', 'sql'},
		})
	end,
}}
