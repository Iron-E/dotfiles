local old_notify = vim.notify
vim.api.nvim_set_keymap("n", "<Leader>u", "", {
	desc = "Toggle vim._core.ui2",
	callback = function()
		local ui2 = require("vim._core.ui2")
		local enabled = ui2.cfg.enable
		ui2.enable({ enable = not enabled })
		if enabled then
			require("mini.notify").setup()

			vim.notify = MiniNotify.make_notify({
				DEBUG = { hl_group = "DiagnosticFloatingHint" },
				ERROR = { hl_group = "DiagnosticFloatingError" },
				INFO = { hl_group = "DiagnosticFloatingInfo" },
				TRACE = { hl_group = "DiagnosticFloatingOk" },
				WARN = { hl_group = "DiagnosticFloatingWarn" },
			})

			if vim.fn.exists(":Messages") == 0 then
				vim.api.nvim_create_user_command("Messages", "lua MiniNotify.show_history()", {
					desc = "Show MiniNotify log",
				})
			end
		else
			vim.notify = old_notify
			vim.lsp.handlers["$/progress"] = vim.lsp.handlers["$/progress before mini.notify"]
		end

		vim.notify("ui2 " .. (enabled and "disabled" or "enabled"), vim.log.levels.INFO)
	end,
})
