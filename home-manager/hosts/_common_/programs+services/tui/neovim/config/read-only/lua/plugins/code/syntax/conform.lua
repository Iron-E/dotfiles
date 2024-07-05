return {{ 'stevearc/conform.nvim',
	cmd = 'ConformInfo',
	event = 'BufWritePre',
	keys = {{
		'gq',
		function() require('conform').format { async = true, lsp_fallback = true } end,
		mode = '',
		desc = 'Format buffer',
	}},
	opts = function(_, o)
		o.formatters_by_ft = {
			css = { 'prettierd' },
			go = { 'gci', 'gofmt' },
			javascript = { 'prettierd' },
			javascriptreact = { 'prettierd', 'rustywind' },
			json = { 'prettierd' },
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
