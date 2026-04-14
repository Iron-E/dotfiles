--- @module 'mini.icons'
--- @module 'string.buffer'

local group = vim.api.nvim_create_augroup("config.tabline", { clear = true })

require("plugins.tabline.showtabline")
local Cache = require("plugins.tabline.cache")

--- @class iron-e.plugins.tabline.Segment
--- @field hl? string
--- @field inherit_hl? boolean
--- @field content? string

--- @param sbuf string.buffer
--- @param segment iron-e.plugins.tabline.Segment
local function format(sbuf, segment)
	if segment.hl then
		if segment.inherit_hl then
			sbuf:putf("%%$%s$", segment.hl)
		else
			sbuf:putf("%%#%s#", segment.hl)
		end
	end

	if segment.content then
		sbuf:put(segment.content)
	end
end

--- @class iron-e.plugins.Tabline
local M = {}

local sbuf = require("string.buffer").new()

--- @return iron-e.plugins.tabline.Segment[]
local function make_segment_group(bufnr)
	local segment_group = {}

	local hl_base = "Buffer" .. Cache.activities_by_bufnr[bufnr]
	local hl_default = hl_base .. (Cache.modified_by_byfnr[bufnr] and "Mod" or "")

	table.insert(segment_group, {
		hl = hl_base .. "Sign",
		content = "",
	})

	table.insert(segment_group, { hl = hl_default, content = " " })

	local name = Cache.names_by_bufnr[bufnr] or "[No Name]"
	local icon, icon_hl = MiniIcons.get("file", name)

	table.insert(segment_group, {
		hl = icon_hl,
		inherit_hl = true,
		content = icon,
	})

	table.insert(segment_group, {
		hl = hl_default,
		content = " " .. name .. " ",
	})

	table.insert(segment_group, {
		hl = hl_base .. "Sign",
		content = "",
	})
end

function M.render()
	if Cache.last_statusline ~= nil then
		return Cache.last_statusline
	end

	--- @type iron-e.plugins.tabline.Segment[][]
	local segment_groups = {}

	local current_segment_group = nil

	for i, bufnr in ipairs(Cache.listed_bufs) do
		if bufnr == Cache.current_buf then
			current_segment_group = i
		end

		segment_groups[i] = {}

		local hl_base = "Buffer" .. Cache.activities_by_bufnr[bufnr]
		local hl_default = hl_base .. (Cache.modified_by_byfnr[bufnr] and "Mod" or "")

		table.insert(segment_groups[i], {
			hl = hl_base .. "Sign",
			content = "",
		})

		table.insert(segment_groups[i], { hl = hl_default, content = " " })

		local name = Cache.names_by_bufnr[bufnr] or "[No Name]"
		local icon, icon_hl = MiniIcons.get("file", name)

		table.insert(segment_groups[i], {
			hl = icon_hl,
			inherit_hl = true,
			content = icon,
		})

		table.insert(segment_groups[i], {
			hl = hl_default,
			content = " " .. name .. " ",
		})

		table.insert(segment_groups[i], {
			hl = hl_base .. "Sign",
			content = "",
		})
	end

	local final_segment_groups = {}

	while true do
		local width = 0
		for _, segment_group in ipairs(segment_groups) do
			for _, segment in ipairs(segment_group) do
				if segment.content ~= nil then
					width = width + vim.api.nvim_strwidth(segment.content)
				end
			end
		end

		if width < Cache.columns then
			break
		end

		local left = current_segment_group - 1
		local right = #segment_groups - current_segment_group

		if left < right then
			table.remove(segment_groups)
		else
			table.remove(segment_groups, 1)
			current_segment_group = current_segment_group - 1
		end
	end

	table.insert(segment_groups, { {
		hl = "TabLineFill",
	} })

	for _, segment_group in ipairs(segment_groups) do
		for _, segment in ipairs(segment_group) do
			format(sbuf, segment)
		end
	end

	sbuf:put("%#TabLineFill#")

	Cache.last_statusline = sbuf:get()
	return Cache.last_statusline
end

vim.api.nvim_set_option_value("tabline", "%!v:lua.require('plugins.tabline').render()", {})

return M
