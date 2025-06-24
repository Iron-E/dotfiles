--- @module 'lazy'

--- @type LazySpec[]
return {{ 'stevearc/conform.nvim',
	cmd = {
		'ConformInfo',
		'ConformToggle',
	},

	event = 'BufWritePre',

	keys = {
		{ 'gq',
			function() require('conform').format { async = true, lsp_fallback = true } end,
			mode = '',
			desc = 'Format buffer',
		},
		{ '<Leader>Gq', '<Cmd>ConformToggle<CR>', mode = 'n' },
	},

	config = function(_, opts)
		local conform = require 'conform'
		conform.setup(opts)

		local enabled = true
		vim.api.nvim_create_user_command(
			'ConformToggle',
			function()
				local toggle_opts = opts
				local log_msg = 'enabled'

				if enabled then -- disable
					toggle_opts = {}
					log_msg = 'disabled'
				end

				enabled = not enabled
				conform.setup(toggle_opts)
				vim.notify('conform.nvim: ' .. log_msg, vim.log.levels.INFO)
			end,
			{
				desc = 'Toggle conform.nvim for all buffers.',
				nargs = 0,
			}
		)
	end,

	--- @param o conform.setupOpts
	opts = function(_, o)
		o.formatters_by_ft = {
			cs = { 'csharpier' },
			css = { 'prettierd' },
			gleam = { 'gleam' },
			go = { 'gci', 'gofmt' },
			javascript = { 'prettierd' },
			javascriptreact = { 'prettierd', 'rustywind' },
			json = { 'prettierd' },
			jsonnet = { 'jsonnetfmt' },
			proto = { 'buf' },
			rust = { 'rustfmt' },
			sh = { 'shellcheck' },
			terraform = { 'terraform_fmt' },
			yaml = { 'prettierd' },
		}

		o.formatters_by_ft.less = o.formatters_by_ft.css
		o.formatters_by_ft.sass = o.formatters_by_ft.scss
		o.formatters_by_ft.scss = o.formatters_by_ft.css
		o.formatters_by_ft.typescript = o.formatters_by_ft.javascript
		o.formatters_by_ft.typescriptreact = o.formatters_by_ft.javascriptreact

		o.format_on_save = function(bufnr)
			if vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == 'lua' then
				return nil
			end

			return { lsp_fallback = true, timeout_ms = 500 }
		end

		o.formatters = {
			yq = { args = { '-y' } },
		}

		o.log_level = vim.log.levels.OFF
	end,
}}
