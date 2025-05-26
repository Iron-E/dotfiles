return {{ 'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	build = ':TSUpdate',
	cond = vim.g.man ~= true,
	event = vim.g.lazy_event_file_read,
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

		vim.api.nvim_create_autocmd('FileType', {
			desc = 'Auto-install parsers for each buffer',
			group = 'config',
			callback = function(ev)
				local ft = ev.match
				local installed = false

				local parsers = require('nvim-treesitter.config').installed_parsers()
				for _, value in ipairs(parsers) do
					if value == ft then
						installed = true
						break
					end
				end

				if installed then
					return
				end

				require('nvim-treesitter').install({ ft }):await(function()
					vim.api.nvim_command 'TSBufEnable'
				end)
			end,
		})
	end,
	setup = function()
		local ts = require 'nvim-treesitter'
		ts.install {
			-- won't get auto installed
			'diff',
			'http',
			'markdown_inline',
			'printf',
			'regex',

			-- I maintain queries for these languages
			'bash',
			'c',
			'c_sharp',
			'css',
			'devicetree',
			'dockerfile',
			'fish',
			'git_config',
			'gitignore',
			'git_rebase',
			'gleam',
			'go',
			'gomod',
			'gotmpl',
			'html',
			'ini',
			'java',
			'javascript',
			'jq',
			'jsonnet',
			'lua',
			'markdown',
			'mermaid',
			'nix',
			'proto',
			'python',
			'query',
			'rust',
			'sql',
			'terraform',
			'toml',
			'tsx',
			'typescript',
			'typst',
			'ungrammar',
			'vim',
			'vimdoc',
			'xml',
			'yaml',
		}
	end,
}}
