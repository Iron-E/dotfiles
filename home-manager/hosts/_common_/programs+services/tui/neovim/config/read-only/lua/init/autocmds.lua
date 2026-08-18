local augroup = vim.api.nvim_create_augroup("config", { clear = false })

--- Whether the window is just a normal editing window
--- @param win integer
--- @return boolean
local function win_is_normal(win)
	return vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative == ""
end

--- HACK: If OptionSet told me which buffer an option was set for, this could all go away.
---       But alas, it does not. So I must waste cpu cycles by hammering in
--- @param from string
--- @param derive fun(v: unknown): { [string]: unknown }
local function propagate_optionset_event(from, derive)
	local function set()
		local options = derive(vim.api.nvim_get_option_value(from, { scope = "local" }))
		for key, value in pairs(options) do
			vim.api.nvim_set_option_value(key, value, { scope = "local" })
		end
	end

	--- @param wins integer[]
	local function set_for_wins(wins)
		for _, win in ipairs(wins) do
			if win_is_normal(win) then
				vim.api.nvim_win_call(win, set)
			end
		end
	end

	local function default_cb()
		set_for_wins(vim.api.nvim_list_wins())
	end

	local desc = "Synchronize options with " .. from

	vim.api.nvim_create_autocmd("FileType", {
		desc = desc,
		group = augroup,
		callback = function(ev)
			set_for_wins(vim.fn.win_findbuf(ev.buf))
		end,
	})

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained", "VimResume" }, {
		desc = desc,
		group = augroup,
		callback = default_cb,
	})

	vim.api.nvim_create_autocmd("OptionSet", {
		desc = desc,
		group = augroup,
		pattern = from,
		callback = default_cb,
	})

	-- Call once after startup
	vim.api.nvim_create_autocmd("UIEnter", {
		desc = desc,
		group = augroup,
		callback = vim.schedule_wrap(default_cb),
	})
end

propagate_optionset_event("foldexpr", function(fde)
	local foldmethod
	if fde == "0" then
		foldmethod = "indent"
	else
		foldmethod = "expr"
	end

	return { foldmethod = foldmethod }
end)

propagate_optionset_event("tabstop", function(ts)
	return {
		list = true,
		listchars = "nbsp:␣,tab:│ ,trail:•,leadmultispace:│" .. string.rep(" ", ts - 1),
		showbreak = "└ ",
	}
end)

propagate_optionset_event("textwidth", function(tw)
	return { colorcolumn = tostring(tw) }
end)

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
	command = [[if mode() == 'n' && getcmdwintype() == '' | checktime | endif]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight yanks",
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Set system clipboard",
		group = augroup,
		command = [[call system('clip.exe ',@")]],
	})
end
