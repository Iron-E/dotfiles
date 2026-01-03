--- @type vim.api.keyset.option
local scope_local = { scope = "local" }

local no_opts = {}

vim.api.nvim_create_user_command("Win", function(tbl)
	local bufwinnr = vim.fn.bufwinid(tbl.args)
	vim.api.nvim_set_current_win(bufwinnr)
end, {
	complete = function()
		return vim.iter(vim.api.nvim_list_bufs())
			:filter(function(bufnr)
				return vim.fn.bufwinid(bufnr) ~= -1
			end)
			:map(vim.fn.bufname)
			:totable()
	end,
	desc = "Focus the given window",
	nargs = 1,
})

-- Space-Tab Conversion
vim.api.nvim_create_user_command("SpacesToTabs", function(tbl)
	vim.api.nvim_set_option_value("expandtab", false, scope_local)
	local previous_tabstop = vim.api.nvim_get_option_value("tabstop", no_opts)
	vim.api.nvim_set_option_value("tabstop", tonumber(tbl.args), scope_local)
	vim.api.nvim_command("retab!")
	vim.api.nvim_set_option_value("tabstop", previous_tabstop, scope_local)
end, { force = true, nargs = 1 })

vim.api.nvim_create_user_command("Typora", function(tbl)
	vim.system({ "typora", tbl.args == "" and vim.api.nvim_buf_get_name(0) or tbl.args }, { detach = true })
end, { complete = "file", nargs = "?" })

vim.api.nvim_create_user_command("TabsToSpaces", function(tbl)
	vim.api.nvim_set_option_value("expandtab", true, scope_local)
	local previous_tabstop = vim.api.nvim_get_option_value("tabstop", scope_local)
	vim.api.nvim_set_option_value("tabstop", tonumber(tbl.args), scope_local)
	vim.api.nvim_command("retab")
	vim.api.nvim_set_option_value("tabstop", previous_tabstop, scope_local)
end, { force = true, nargs = 1 })

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
