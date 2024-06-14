return { {
	'stevearc/conform.nvim',
	cmd = 'ConformInfo',
	event = 'BufWritePre',
	keys = { {
		'gq',
		function() require('conform').format { async = true, lsp_fallback = true } end,
		mode = '',
		desc = 'Format buffer',
	} },
	opts = function(_, o)
		o.formatters_by_ft = {
			go = { 'gci', 'gofmt' },
			javascript = { 'prettierd' },
			javascriptreact = { 'prettierd', 'rustywind' },
			rust = { 'rustfmt' },
			sh = { 'shellcheck' },
			terraform = { 'terraform_fmt' },
			toml = { 'yq' },
			xml = { 'yq' },
			yaml = { 'yq' },
		}

		o.formatters_by_ft.less = o.formatters_by_ft.css
		o.formatters_by_ft.sass = o.formatters_by_ft.scss
		o.formatters_by_ft.scss = o.formatters_by_ft.css
		o.formatters_by_ft.typescript = o.formatters_by_ft.javascript
		o.formatters_by_ft.typescriptreact = o.formatters_by_ft.javascriptreact

		o.format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		}

		o.formatters = {
			yq = { args = { '-y' } },
		}

		o.log_level = vim.log.levels.OFF
	end,
} }
