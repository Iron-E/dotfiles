return {{ 'echasnovski/mini.splitjoin',
	config = function()
		local split_join = require 'mini.splitjoin'
		local gen_hook = split_join.gen_hook

		local brace = '%b{}'
		local bracket = '%b[]'
		local paren = '%b()'

		local all = { brackets = { brace, bracket, paren } }
		local braces = { brackets = { brace } }
		local not_parens = { brackets = { brace, bracket } }

		split_join.setup
		{
			detect = { separator = ',' },
			join = { hooks_post = { gen_hook.del_trailing_separator(all), gen_hook.pad_brackets(braces) } },
			split = { hooks_post = { gen_hook.add_trailing_separator(not_parens) } },
		}

		local bvar = 'minisplitjoin_config'
		vim.api.nvim_create_autocmd('FileType', {
			callback = function(ev)
				vim.api.nvim_buf_set_var(ev.buf, bvar, { split = { hooks_post = { gen_hook.add_trailing_separator(all) } } })
			end,
			group = 'config',
			pattern = { 'go', 'rust', 'typescript', 'typescriptreact', 'typst' },
		})

		vim.api.nvim_create_autocmd('FileType', {
			callback = function(ev) vim.api.nvim_buf_set_var(ev.buf, bvar, { split = { hooks_post = {} } }) end,
			group = 'config',
			pattern = { 'json', 'nix', 'sql' },
		})
	end,
}}
