return {{ 'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	cond = vim.g.man ~= true,
	event = vim.g.lazy_read_file_event,
	main = 'nvim-treesitter.configs',
	init = function()
		local ts_utils = require 'ts_utils' --- @type config.TSUtils
		vim.api.nvim_create_user_command('ShowAs',
			function(tbl)
				local file_ext, node_type = unpack(tbl.fargs)
				local node = ts_utils.get_next_ancestor(node_type)
				if node == nil then
					return vim.notify('No ' .. node_type .. ' at cursor', vim.log.levels.INFO)
				end

				ts_utils.in_floating_window(node, file_ext)
			end,
			{ complete = 'filetype', desc = 'Show $2 TS node in float with $1 file extension ', nargs = '+' }
		);
	end,
	opts = function(_, o)
		o.auto_install = true
		o.ensure_installed = {
			-- won't get auto installed
			'http',
			'markdown_inline',
			'printf',
			'regex',

			-- I maintain queries for these languages
			'bash',
			'c',
			'c_sharp',
			'css',
			'dockerfile',
			'fish',
			'git_config',
			'git_rebase',
			'gitignore',
			'gleam',
			'go',
			'gomod',
			'html',
			'ini',
			'java',
			'javascript',
			'jq',
			'lua',
			'markdown',
			'markdown_inline',
			'nix',
			'python',
			'query',
			'regex',
			'rust',
			'sql',
			'toml',
			'typescript',
			'typst',
			'ungrammar',
			'vim',
			'vimdoc',
			'yaml',
		}
		o.highlight = { additional_vim_regex_highlighting = false, enable = true }
		o.indent = { enable = false }

		vim.treesitter.language.register('bash', { 'env', 'zsh' })
		vim.treesitter.language.register('gitignore', 'dockerignore')
	end,
}}
