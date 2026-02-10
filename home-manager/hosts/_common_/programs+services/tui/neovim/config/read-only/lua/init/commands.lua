--- @type vim.api.keyset.option
local scope_local = { scope = "local" }

local no_opts = {}

vim.api.nvim_create_user_command("SetTabstop", function(tbl)
	local expandtab = tbl.bang
	local tabstop = 3
	if tbl.args ~= "" then
		local input_num = tonumber(tbl.args)
		if input_num == nil then
			vim.notify("Argument to SetTabstop must be a number", vim.log.levels.ERROR)
			return
		end

		tabstop = input_num
	end

	--- @type vim.api.keyset.option
	local opts = { scope = "local" }

	vim.api.nvim_set_option_value("expandtab", expandtab, opts)
	vim.api.nvim_set_option_value("shiftwidth", 0, opts) -- Use tabstop
	vim.api.nvim_set_option_value("softtabstop", -1, opts) -- Use shiftwidth
	vim.api.nvim_set_option_value("tabstop", tabstop, opts) -- How many spaces a tab is worth
end, { force = true, bang = true, nargs = "?" })

-- Space-Tab Conversion
vim.api.nvim_create_user_command("SpacesToTabs", function(tbl)
	vim.api.nvim_set_option_value("expandtab", false, scope_local)
	local previous_tabstop = vim.api.nvim_get_option_value("tabstop", no_opts)
	vim.api.nvim_set_option_value("tabstop", tonumber(tbl.args), scope_local)
	vim.api.nvim_command("retab!")
	vim.api.nvim_set_option_value("tabstop", previous_tabstop, scope_local)
end, { force = true, nargs = 1 })

vim.api.nvim_create_user_command("TabsToSpaces", function(tbl)
	vim.api.nvim_set_option_value("expandtab", true, scope_local)
	local previous_tabstop = vim.api.nvim_get_option_value("tabstop", scope_local)
	vim.api.nvim_set_option_value("tabstop", tonumber(tbl.args), scope_local)
	vim.api.nvim_command("retab")
	vim.api.nvim_set_option_value("tabstop", previous_tabstop, scope_local)
end, { force = true, nargs = 1 })

vim.api.nvim_create_user_command("Typora", function(tbl)
	vim.system({ "typora", tbl.args == "" and vim.api.nvim_buf_get_name(0) or tbl.args }, { detach = true })
end, { complete = "file", nargs = "?" })

-- Fat fingering
vim.api.nvim_create_user_command("W", "w", no_opts)
vim.api.nvim_create_user_command("Wq", "wq", no_opts)
vim.api.nvim_create_user_command("Wqa", "wqa", no_opts)
vim.api.nvim_create_user_command("X", "x", no_opts)
vim.api.nvim_create_user_command("Xa", "xa", no_opts)

--------------
-- toggling --
--------------

--- @param option string the name of the option
--- @param setlocal? boolean the `nvim_set_option_value` options
--- @param map? (fun(value: unknown): unknown) the `nvim_set_option_value` options
--- @return fun(): nil
local function toggle(option, setlocal, map)
	return function()
		local old_value = vim.api.nvim_get_option_value(option, no_opts)
		local new_value
		if map then
			new_value = map(old_value)
		else
			new_value = not old_value
		end

		local opts = no_opts
		if setlocal then
			opts = scope_local
		end

		vim.api.nvim_set_option_value(option, new_value, opts)
	end
end

vim.api.nvim_create_user_command("TogglePaste", toggle("paste"), no_opts)
vim.api.nvim_create_user_command("ToggleWinWrap", toggle("wrap", true), no_opts)
vim.api.nvim_create_user_command("ToggleWinSpell", toggle("spell", true), no_opts)

vim.api.nvim_create_user_command(
	"ToggleWinConcealLevel",
	toggle("conceallevel", true, function(v)
		return v < 2 and 2 or 0
	end),
	no_opts
)

vim.api.nvim_create_user_command(
	"ToggleMouse",
	toggle("mouse", false, function(v)
		return v == "" and "nvi" or ""
	end),
	no_opts
)

do
	--- @param pattern string
	--- @param mode? 'previous'|'next'|'first'|'last'
	local function jump(pattern, mode)
		local win = vim.api.nvim_get_current_win()
		local buf = vim.api.nvim_win_get_buf(win)

		local old_curpos = vim.api.nvim_win_get_cursor(win)

		local flags = "n"

		if mode == "first" then
			flags = flags .. "c"
			vim.api.nvim_win_set_cursor(win, { 1, 0 })
		elseif mode == "previous" then
			flags = flags .. "b"
		elseif mode == "last" then
			flags = flags .. "bc"

			local lnum = vim.api.nvim_buf_line_count(buf)
			vim.api.nvim_win_set_cursor(win, { lnum, 1 })
		end

		local lnum, col = unpack(vim.fn.searchpos(pattern, flags))

		if lnum == 0 and col == 0 then
			vim.api.nvim_win_set_cursor(0, old_curpos)
			return
		end

		vim.api.nvim_buf_set_mark(buf, "'", old_curpos[1], old_curpos[2], {})
		vim.api.nvim_win_set_cursor(0, { lnum, col - 1 })
	end

	for _, mode in ipairs({ "previous", "next", "first", "last" }) do
		vim.api.nvim_create_user_command("J" .. mode, function(args)
			jump(args.args, mode)
		end, {
			nargs = 1,
			force = true,
			desc = "Jump to the " .. mode .. " occurrence of a pattern",
		})
	end
end

do
	--- @param pattern string
	--- @param is_loclist boolean
	local function setlist(pattern, is_loclist)
		local win = vim.api.nvim_get_current_win()
		local buf = vim.api.nvim_win_get_buf(win)

		local results = vim.fn.matchbufline(buf, pattern, 1, "$", vim.empty_dict())

		local name = vim.api.nvim_buf_get_name(buf)

		local list = vim.iter(ipairs(results))
			:map(function(_, v)
				--- @type vim.quickfix.entry
				return {
					bufnr = buf,
					filename = name,
					lnum = v.lnum,
					pattern = pattern,
					col = 0,
					text = v.text,
				}
			end)
			:totable()

		if is_loclist then
			vim.fn.setloclist(win, list, "r")
			vim.api.nvim_command("lopen")
		else
			vim.fn.setqflist(list, "r")
			vim.api.nvim_command("copen")
		end
	end

	for _, mode in ipairs({ "loclist", "qflist" }) do
		local is_loclist = mode == "loclist"
		vim.api.nvim_create_user_command("J" .. mode, function(args)
			setlist(args.args, is_loclist)
		end, {
			nargs = 1,
			force = true,
			desc = "Jump to the " .. mode .. " occurrence of a pattern",
		})
	end
end
