local augroup = vim.api.nvim_create_augroup("config", { clear = false })

--- Whether the buffer is a normal editing buffer
--- @param buf integer
--- @return boolean
local function buf_is_normal(buf)
	local opts = { buf = buf }
	return vim.api.nvim_buf_is_valid(buf)
		and vim.api.nvim_get_option_value("buflisted", opts)
		and vim.api.nvim_get_option_value("buftype", opts) == ""
end

--- Whether the window is just a normal editing window
--- @param win integer
--- @return boolean
local function win_is_normal(win)
	return vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative == ""
end

--- @param buf integer
--- @param options { [string]: any }
local function set_option_for_all(buf, options)
	if not buf_is_normal(buf) then
		return
	end

	local win_scope = {} --- @type string[]
	local other_scope = {} --- @type { [string]: "buf"|"global" }
	for key, _ in pairs(options) do
		local info = vim.api.nvim_get_option_info2(key, { scope = "local" })
		if info.scope == "win" then
			table.insert(win_scope, key)
		else
			--- @diagnostic disable-next-line:assign-type-mismatch
			other_scope[key] = info.scope
		end
	end

	if #win_scope ~= 0 then
		for _, win in ipairs(vim.fn.win_findbuf(buf)) do
			if not win_is_normal(win) then
				goto continue
			end

			for _, key in ipairs(win_scope) do
				vim.api.nvim_set_option_value(key, options[key], { win = win })
			end

			::continue::
		end
	end

	for key, scope in pairs(other_scope) do
		local opts = {}
		if scope == "buf" then
			opts.buf = buf
		end

		vim.api.nvim_set_option_value(key, options[key], opts)
	end
end

--- HACK: If OptionSet told me which buffer an option was set for, this could all go away.
---       But alas, it does not. So I must waste cpu cycles by hammering in
--- @param from string
--- @param derive fun(v: unknown): { [string]: unknown }
local function propagate_optionset_event(from, derive)
	vim.api.nvim_create_autocmd({
		"CursorHold",
		"CursorHoldI",
		"FocusGained",
		"VimResume",
	}, {
		desc = "Synchronize options with " .. from,
		group = augroup,
		callback = function()
			local function set()
				local options = derive(vim.api.nvim_get_option_value(from, { scope = "local" }))
				for key, value in pairs(options) do
					vim.api.nvim_set_option_value(key, value, { scope = "local" })
				end
			end

			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if win_is_normal(win) then
					vim.api.nvim_win_call(win, set)
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd({
		"BufWinEnter",
		"BufWritePost",
		"FileChangedShellPost",
		"FileType",
		"InsertLeave",
	}, {
		desc = "Synchronize options with " .. from,
		group = augroup,
		callback = function(ev)
			local options = derive(vim.api.nvim_get_option_value(from, { scope = "local" }))
			set_option_for_all(ev.buf, options)
		end,
	})

	vim.api.nvim_create_autocmd("OptionSet", {
		desc = "Synchronize options with " .. from,
		group = augroup,
		pattern = from,
		callback = function()
			local options = derive(vim.api.nvim_get_option_value(from, { scope = "local" }))
			set_option_for_all(vim.api.nvim_get_current_buf(), options)
		end,
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
