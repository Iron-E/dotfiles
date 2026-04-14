--- @alias iron-e.plugins.tabline.activity 'Current'|'Visible'|'Alternate'|'Inactive'

--- @class iron-e.plugins.tabline.Cache
local M = {
	columns = 0,

	last_statusline = nil,

	current_buf = nil,

	--- @type {[integer]: string}
	names_by_bufnr = {},

	--- @type integer[]
	listed_bufs = {},

	--- @type {[integer]: iron-e.plugins.tabline.activity}
	activities_by_bufnr = {},

	--- @type {[integer]: boolean}
	modified_by_byfnr = {},
}

--- @param bufnr integer
--- @return iron-e.plugins.tabline.activity
local function buf_activity(bufnr)
	if bufnr == vim.api.nvim_get_current_buf() then
		M.current_buf = bufnr
		return 'Current'
	elseif bufnr == vim.fn.bufnr("#")  then
		M.alternate_buf = bufnr
		return 'Alternate'
	elseif vim.fn.bufwinid(bufnr) == -1 then
		return 'Inactive'
	else
		return 'Visible'
	end
end

vim.api.nvim_create_autocmd('BufModifiedSet', {
	desc = "Update tabline modified status",
	group = "config.tabline",
	callback = function(ev)
		M.modified_by_byfnr[ev.buf] = vim.api.nvim_get_option_value("modified", {buf = ev.buf})
		M.last_statusline = nil
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "UIEnter", "VimEnter", "WinEnter" }, {
	desc = "Update tabline buffer activities",
	group = "config.tabline",
	callback = function(ev)
		for _, bufnr in ipairs(M.listed_bufs) do
			M.activities_by_bufnr[bufnr] = buf_activity(bufnr)
		end

		if ev.event == "WinEnter" then
			M.current_buf = ev.buf
		end

		M.last_statusline = nil
	end
})

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "UIEnter", "VimEnter" }, {
	desc = "Update tabline buffer names",
	group = "config.tabline",
	callback = function()
		--- @type {[string]: {bufnrs: { [integer]: string }, count: integer}}
		local bufs_by_name = {}

		M.listed_bufs = {}

		-- step 1: get all the buffer names
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if not vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
				goto continue
			end

			table.insert(M.listed_bufs, bufnr)

			local full_name = vim.api.nvim_buf_get_name(bufnr)
			if full_name == "" then
				goto continue
			end

			local name = vim.fs.basename(full_name)

			if bufs_by_name[name] == nil then
				bufs_by_name[name] = { count = 0, bufnrs = {} }
			end

			bufs_by_name[name].bufnrs[bufnr] = vim.fs.dirname(full_name)
			bufs_by_name[name].count = bufs_by_name[name].count + 1

			::continue::
		end

		-- step 2: continually deduplicate buffer names until all are unique
		local all_unique
		repeat
			all_unique = true

			for name, bufs in pairs(bufs_by_name) do
				if bufs.count < 2 then
					if bufs.count == 0 then
						bufs_by_name[name] = nil
					end

					goto continue
				end

				all_unique = false

				for bufnr, path in pairs(bufs.bufnrs) do
					local new_name = vim.fs.joinpath(vim.fs.basename(path), name)

					if bufs_by_name[new_name] == nil then
						bufs_by_name[new_name] = { count = 0, bufnrs = {} }
					end

					bufs_by_name[new_name].bufnrs[bufnr] = vim.fs.dirname(path)
					bufs_by_name[new_name].count = bufs_by_name[new_name].count + 1

					bufs.bufnrs[bufnr] = nil
					bufs.count = bufs.count - 1
				end

			    ::continue::
			end
		until all_unique

		M.names_by_bufnr = {}
		for name, bufnrs in pairs(bufs_by_name) do
			for bufnr, _ in pairs(bufnrs.bufnrs) do
				M.names_by_bufnr[bufnr] = name
				break
			end
		end

		M.last_statusline = nil
	end,
})

vim.api.nvim_create_autocmd({"UIEnter", 'VimResized'}, {
	desc = "Cache vim width",
	group = "config.tabline",
	callback = function()
		M.columns = vim.api.nvim_get_option_value("columns", {})
		M.last_statusline = nil
	end,
})

return M
