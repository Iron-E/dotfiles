return {{ 'echasnovski/mini.notify', config = function()
	local notify = require 'mini.notify'
	notify.setup()

	vim.notify = notify.make_notify {
		DEBUG = { hl_group = 'DiagnosticFloatingHint' },
		ERROR = { hl_group = 'DiagnosticFloatingError' },
		INFO  = { hl_group = 'DiagnosticFloatingInfo' },
		TRACE = { hl_group = 'DiagnosticFloatingOk' },
		WARN  = { hl_group = 'DiagnosticFloatingWarn' },
	}

	vim.api.nvim_create_user_command('Messages', 'lua MiniNotify.show_history()', { desc = 'Show MiniNotify log' })
end }}
