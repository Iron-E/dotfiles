return {{ 'mfussenegger/nvim-lint',
	config = function(_, o)
		local lint = require 'lint'
		lint.linters_by_ft = o
		table.insert(lint.linters.vale.args, 1, '--config=' .. vim.fn.stdpath('config') .. '/../vale/config.ini')

		vim.api.nvim_create_autocmd('BufWritePost', {
			callback = function() lint.try_lint() end,
			group = 'config',
		})
	end,
	event = vim.g.lazy_event_file_read,
	opts = function(_, o)
		o.ansible = { 'ansible_lint' }
		o.env = { 'dotenv_linter' }
		o.fish = { 'fish' }
		o.html = { 'htmlhint' }
		o.javascript = { 'eslint_d' }
		o.javascriptreact = o.javascript
		o.markdown = { 'vale' }
		o.nix = { 'deadnix' }
		o.nix = { 'nix' }
		o.python = { 'ruff' }
		o.sql = { 'sqlfluff' }
		o.terraform = { 'tflint', 'tfsec' }
		o.text = { 'vale' }
		o.typescript = o.javascript
		o.typescriptreact = o.typescript
	end,
}}
