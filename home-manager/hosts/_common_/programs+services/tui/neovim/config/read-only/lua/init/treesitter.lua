------------
-- config --
------------

vim.treesitter.language.register("bash", { "env", "zsh" })
vim.treesitter.language.register("hcl", { "hcl.terragrunt", "hcl.terragrunt-stack" })
vim.treesitter.language.register("gitignore", { "dockerignore", "helmignore" })
vim.treesitter.language.register("ini", { "systemd" })
vim.treesitter.language.register("terraform", {
	"opentofu",
	"opentofu-vars",
	"treesitter-vars",
})

--------------
-- mappings --
--------------

-- Highlighting inspect
vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>Inspect<CR>", {})

-- Syntax tree inspect
vim.api.nvim_set_keymap("n", "<F11>", "", {
	callback = function()
		local winnr = vim.api.nvim_get_current_win()
		local cursor = vim.api.nvim_win_get_cursor(winnr)

		vim.api.nvim_command("InspectTree")
		local inspect_winnr = vim.api.nvim_get_current_win()

		vim.api.nvim_set_current_win(winnr)
		vim.api.nvim_win_set_cursor(winnr, cursor)
		vim.api.nvim_set_current_win(inspect_winnr)
	end,
})

------------
-- enable --
------------

--- @class iron-e.TSWinEnable
---@field winid? integer
---@field bufnr? integer
---@field restart? boolean

do
	local remaps = {
		["in"] = "<C-i>",
		["an"] = "<C-o>",
		["[n"] = "[n",
		["]n"] = "]n",
	}

	local keymap = vim.api.nvim_get_keymap("x")
	for _, mapping in ipairs(keymap) do
		local remap = remaps[mapping.lhs]
		if remap then
			vim.api.nvim_set_keymap("x", remap, "", {
				callback = mapping.callback,
				desc = mapping.desc,
				noremap = true,
			})
		end
	end
end

--- Enable treesitter for the current buffer.
--- @param opts iron-e.TSWinEnable
local function ts_win_enable(opts)
	local winid = opts.winid
	local bufnr = opts.bufnr
	if bufnr == nil and winid == nil then
		bufnr = vim.api.nvim_get_current_buf()
		winid = vim.api.nvim_get_current_win()
	elseif bufnr == nil and winid ~= nil then
		bufnr = vim.api.nvim_win_get_buf(winid)
	elseif bufnr ~= nil and winid == nil then
		winid = vim.fn.bufwinid(bufnr)
	end

	--- @cast bufnr -nil
	--- @cast winid -nil

	if opts.restart then
		pcall(vim.treesitter.stop, bufnr)
	end

	local ok = pcall(vim.treesitter.start, bufnr)
	if not ok then -- could not start treesitter
		return
	end

	-- use treesitter for folds
	vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { win = winid })
end

vim.api.nvim_create_user_command("TSWinEnable", function(args)
	local winid
	local bufnr
	if #args.fargs > 0 then
		winid = tonumber(args.fargs[1])

		if #args.fargs > 1 then
			bufnr = tonumber(args.fargs[2])
		end
	end

	ts_win_enable({
		winid = winid,
		bufnr = bufnr,
		restart = args.bang,
	})
end, {
	desc = "Try to enable treesitter highlighting for a buffer.",
	nargs = "*",
	bang = true,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Start treesitter for buffer",
	group = "config",
	callback = vim.schedule_wrap(function(ev)
		ts_win_enable({
			winid = vim.api.nvim_get_current_win(),
			bufnr = ev.buf,
		})
	end),
})
