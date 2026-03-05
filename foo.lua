local function foo()
	local char = "<"
	local view = vim.fn.winsaveview()

	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()
	local cursor = vim.api.nvim_win_get_cursor(win)

	return function(...)
		local start = vim.api.nvim_buf_get_mark(buf, "[")[1]
		local end_ = vim.api.nvim_buf_get_mark(buf, "]")[1]

		vim.cmd.normal({
			range = { start, end_ },
			args = { "<<" },
			bang = true,
		})

		-- reset the window view
		vim.fn.winrestview(view)

		-- move the cursor by the amount of the offset
		-- the offset amount depends on whether tabs are used
		local offset = 1
		if vim.api.nvim_get_option_value("expandtab", { buf = buf }) then
			offset = vim.api.nvim_get_option_value("shiftwidth", { buf = buf })
			if offset == 0 then -- the 'shiftwidth' option equals tabstop when 0
				offset = vim.api.nvim_get_option_value("tabstop", { buf = buf })
			end
		end

		if char == "<" then -- de-indent
			cursor[2] = math.max(0, cursor[2] - offset)
		else -- indent
			cursor[2] = cursor[2] + offset
		end

		-- offset cursor
		vim.api.nvim_win_set_cursor(win, cursor)
	end
end

local opfunc_viml_bridge = vim.api.nvim_exec2(
	[[
	  func s:set_opfunc(val)
		 let &opfunc = a:val
	  endfunc
	  echon get(function('s:set_opfunc'), 'name')
	]],
	{
		output = true,
	}
)

--- HACK: see https://github.com/neovim/neovim/issues/14157#issuecomment-1320787927
local set_opfunc = vim.fn[opfunc_viml_bridge.output]

vim.keymap.set("n", "<", function()
	set_opfunc(foo())
	return "g@"
end, { expr = true })
