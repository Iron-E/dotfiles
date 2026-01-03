local augroup = vim.api.nvim_create_augroup("config", { clear = false })

--- Call nvim_set_option_value on another option based on how OptionSet was triggered (e.g. setlocal vs. setglobal)
--- @param option string
--- @param value any
local function propagate_optionset(option, value)
	local oldlocal = vim.v.option_oldlocal
	local oldglobal = vim.v.option_oldglobal

	local opts = {} --- @type vim.api.keyset.option
	if oldlocal and not oldglobal then -- :setlocal
		opts.scope = "local"
	elseif not oldlocal and oldglobal then -- :setglobal
		opts.scope = "global"
	end

	vim.api.nvim_set_option_value(option, value, opts)
end

vim.api.nvim_create_autocmd("OptionSet", {
	desc = "Set foldmethod when expr filled",
	group = augroup,
	pattern = "foldexpr",
	callback = function()
		local foldmethod --- @type string
		if vim.v.option_new == "0" then -- default value
			foldmethod = "indent"
		else
			foldmethod = "expr"
		end

		propagate_optionset("foldmethod", foldmethod)
	end,
})

do
	--- @param buf integer
	local function apply_indent_guide_settings(buf)
		--- @type vim.api.keyset.option
		local opts = {}
		if buf then
			local win = vim.fn.bufwinid(buf)
			if vim.api.nvim_win_is_valid(win) then
				opts.win = win
			end
		end

		local tabstop = vim.api.nvim_get_option_value("tabstop", { buf = buf })
		local listchars = "nbsp:␣,tab:│ ,trail:•,leadmultispace:│" .. string.rep(" ", tabstop - 1)

		vim.api.nvim_set_option_value("list", true, opts)
		vim.api.nvim_set_option_value("listchars", listchars, opts)

		vim.api.nvim_set_option_value("showbreak", "└ ", opts)
	end

	vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost", "InsertLeave" }, {
		desc = "Reset indent guide settings",
		group = augroup,
		callback = function(ev)
			apply_indent_guide_settings(ev.buf)
		end,
	})

	vim.api.nvim_create_autocmd("OptionSet", {
		desc = "Reset indent guide settings",
		group = augroup,
		pattern = "tabstop",
		callback = function(ev)
			apply_indent_guide_settings(ev.buf)
		end,
	})
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Populate colorcolumn based on tw",
	group = augroup,
	callback = function()
		local opts = { scope = "local" }
		local colorcolumn = vim.api.nvim_get_option_value("colorcolumn", opts)
		if colorcolumn ~= "" then -- don't clobber non-default value
			return
		end

		local tw = vim.api.nvim_get_option_value("textwidth", opts)
		vim.api.nvim_set_option_value("colorcolumn", tostring(tw), opts)
	end,
})

vim.api.nvim_create_autocmd("OptionSet", {
	desc = "Set colorcolumn when textwidth changes",
	group = augroup,
	pattern = "textwidth",
	callback = function()
		local tw = tostring(vim.v.option_new)
		propagate_optionset("colorcolumn", tw)
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	desc = "Sync syntax when not editing text",
	group = augroup,
	callback = function(event)
		if vim.api.nvim_get_option_value("syntax", { buf = event.buf }) ~= "" then
			vim.api.nvim_command("syntax sync fromstart")
		end

		if vim.lsp.semantic_tokens then
			vim.lsp.semantic_tokens.force_refresh(event.buf)
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
	desc = "Check for external changes to file",
	group = augroup,
	command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight yanks",
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Set system clipboard",
		group = augroup,
		command = [[call system('clip.exe ',@")]],
	})
end
