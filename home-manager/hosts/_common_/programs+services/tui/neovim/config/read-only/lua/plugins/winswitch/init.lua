--- @class iron-e.plugins.Winswitch
local M = {}

local ns = vim.api.nvim_create_namespace("iron-e.plugins.winswitch")

local labels = {
	"a",
	"s",
	"d",
	"f",
	"j",
	"k",
	"l",
	";",
	"g",
	"h",

	"z",
	"x",
	"c",
	"v",
	"m",
	",",
	".",
	"/",
	"b",
	"n",

	"q",
	"w",
	"e",
	"r",
	"u",
	"i",
	"o",
	"p",
	"t",
	"y",
}

--- Filters out winids that should not be labeled.
---@param winid integer
---@return boolean # whether the winid should be labeled
local function default_should_label_winid(winid)
	-- label it only if the win is valid and it is not floating
	return vim.api.nvim_win_is_valid(winid) and vim.api.nvim_win_get_config(winid).relative == ""
end

--- @return integer[]
local function get_visible_winids()
	local tabid = vim.api.nvim_get_current_tabpage()
	local winids = vim.api.nvim_tabpage_list_wins(tabid)
	return winids
end

--- @param acc { [string]: integer }
--- @param index integer
--- @param winid integer
--- @return { [string]: integer }
local function assign_label(acc, index, winid)
	local label = labels[index]
	acc[label] = winid
	return acc
end

--- @class iron-e.plugins.winswitch.Popup
--- @field bufnr integer
--- @field winid integer

--- @return iron-e.plugins.winswitch.Popup
local function popup_label(label, winid)
	local popup_bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(popup_bufnr, 0, 0, true, { label })

	vim.hl.range(popup_bufnr, ns, "@label", { 0, 0 }, { 0, 1 })

	local pos = vim.api.nvim_win_get_position(winid)

	local popup_winid = vim.api.nvim_open_win(popup_bufnr, false, {
		relative = "editor",
		row = pos[1],
		col = pos[2],
		height = 1,
		width = 1,
		zindex = 500,
		border = { "", "", "", "|", "", "", "", "|" },
		style = "minimal",
	})

	return {
		bufnr = popup_bufnr,
		winid = popup_winid,
	}
end

---@param winids_by_label {[string]: integer}
---@return {[string]: iron-e.plugins.winswitch.Popup} popups_by_label
local function popup_labels(winids_by_label)
	local popups_by_label = {}
	for label, winid in pairs(winids_by_label) do
		local popup = popup_label(label, winid)
		popups_by_label[label] = popup
	end

	return popups_by_label
end

---@param popup iron-e.plugins.winswitch.Popup
local function cleanup_label_popup(popup)
	if vim.api.nvim_win_is_valid(popup.winid) then
		vim.api.nvim_win_close(popup.winid, true)
	end

	if vim.api.nvim_buf_is_valid(popup.bufnr) then
		vim.api.nvim_buf_delete(popup.bufnr, { force = true, unload = false })
	end
end

---@param popups_by_label {[string]: { bufnr: integer, winid: integer }}
local function cleanup_label_popups(popups_by_label)
	for _, popup in pairs(popups_by_label) do
		cleanup_label_popup(popup)
	end
end

---@param valid_labels {[string]: unknown }
---@return nil|string label
local function input_label(valid_labels)
	while true do
		local response = vim.fn.getcharstr()

		if response == "\27" then
			return nil
		elseif valid_labels[response] == nil then
			print("Invalid label: " .. response)
		else
			return response
		end
	end
end

function M.switch_current()
	local current_win = vim.api.nvim_get_current_win()
	local current_buf = vim.api.nvim_win_get_buf(current_win)

	local winids = get_visible_winids()
	local winids_by_label = vim.iter(winids)
		:filter(default_should_label_winid)
		:filter(function(winid)
			return not (winid == current_win or vim.api.nvim_win_get_buf(winid) == current_buf)
		end)
		:enumerate()
		:fold({}, assign_label)

	if vim.tbl_isempty(winids_by_label) then -- no valid windows, don't do anything
		vim.notify("winswitch: too few unique windows", vim.log.levels.ERROR)
		return
	end

	local popups_by_label = popup_labels(winids_by_label)

	vim.schedule(function()
		local success, result = xpcall(function()
			local label = input_label(winids_by_label)
			if label == nil then
				return
			end

			local target_win = winids_by_label[label]
			if current_win == target_win then -- don't bother trying to switch the two windows
				return
			end

			local target_buf = vim.api.nvim_win_get_buf(target_win)

			vim.api.nvim_win_set_buf(current_win, target_buf)
			vim.api.nvim_win_set_buf(target_win, current_buf)
			vim.api.nvim_set_current_win(target_win)
		end, debug.traceback)

		if not success then
			vim.notify(tostring(result), vim.log.levels.ERROR)
		end

		cleanup_label_popups(popups_by_label)
	end)
end

function M.switch()
	local winids = get_visible_winids()
	local winids_by_label = vim.iter(winids):filter(default_should_label_winid):enumerate():fold({}, assign_label)

	local bufnrs_by_winid = vim.iter(pairs(winids_by_label)):fold({}, function(acc, _, winid)
		acc[winid] = vim.api.nvim_win_get_buf(winid)
		return acc
	end)

	if vim.tbl_isempty(winids_by_label) then -- no valid windows, don't do anything
		vim.notify("winswitch: too few unique windows", vim.log.levels.ERROR)
		return
	elseif #vim.iter(pairs(bufnrs_by_winid))
		:unique(function(_, bufnr)
			return bufnr
		end)
		:totable() < 2 then
		vim.notify("winswitch: too few unique buffers", vim.log.levels.ERROR)
		return
	end

	local popups_by_label = popup_labels(winids_by_label)

	local function try_wrap(fn)
		return function()
			local success, result = xpcall(function()
				return fn()
			end, debug.traceback)

			if not success then
				vim.notify(tostring(result), vim.log.levels.ERROR)
				cleanup_label_popups(popups_by_label)
			elseif result == true then
				cleanup_label_popups(popups_by_label)
			end
		end
	end

	-- I think this is probably worse than callback hell
	--
	-- there's multiple levels of "async"/scheduling here,
	-- and each level needs to ensure that if errors occur,
	-- the cleanup stage still goes through.
	--
	-- the best way I could find (until vim.async)
	-- is to instrument each layer of the scheduling with xpcall
	-- and handle the errors in case.
	vim.schedule(try_wrap(function()
		local first_label = input_label(winids_by_label)
		if first_label == nil then
			return true
		end

		local first_winid = winids_by_label[first_label]
		local first_bufnr = bufnrs_by_winid[first_winid]

		local second_winids = vim.deepcopy(winids_by_label, true)
		second_winids[first_label] = nil
		vim.hl.range(popups_by_label[first_label].bufnr, ns, "Visual", { 0, 0 }, { 0, 1 })

		for label, winid in pairs(second_winids) do
			local bufnr = bufnrs_by_winid[winid]
			if bufnr == first_bufnr then
				second_winids[label] = nil
				cleanup_label_popup(popups_by_label[label])
			end
		end

		vim.defer_fn(
			try_wrap(function()
				local second_label = input_label(second_winids)
				if second_label == nil then
					return true -- clean up early
				end

				local second_winid = winids_by_label[second_label]
				local second_bufnr = vim.api.nvim_win_get_buf(second_winid)

				vim.api.nvim_win_set_buf(first_winid, second_bufnr)
				vim.api.nvim_win_set_buf(second_winid, first_bufnr)

				return true
			end),
			25
		)
	end))
end

return M
