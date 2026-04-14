--- @module 'mini.icons'
--- @module 'string.buffer'

local group = vim.api.nvim_create_augroup("config.tabline", { clear = true })

require("plugins.tabline.showtabline")
local Cache = require("plugins.tabline.cache")
local Highlights = require("plugins.tabline.highlights")

--- @class iron-e.plugins.tabline.Segment
--- @field hl string
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

---@param segments iron-e.plugins.tabline.Segment[]
---@param index? integer the segment to splice
---@param actual_width integer the width of the segments
---@param desired_width integer the desired width of the segments
local function splice_segment(segments, index, actual_width, desired_width)
	--- @type iron-e.plugins.tabline.Segment
	local removed_segment = table.remove(segments, index)

	-- cannot splice
	if removed_segment.content == nil then
		return
	end

	local difference = actual_width - desired_width
	local removed_segment_width = vim.api.nvim_strwidth(removed_segment.content)

	if difference > removed_segment_width then -- more segments need to be removed
		return
	end

	local chars_can_take = removed_segment_width - difference

	local start, len
	if index == nil then -- taking from the right
		start = 0
		len = chars_can_take
	else -- taking from the left
		start = removed_segment_width - chars_can_take
		len = chars_can_take
	end

	local new_content = vim.fn.strcharpart(removed_segment.content, start, len)
	removed_segment.content = new_content

	if index == nil then
		table.insert(segments, removed_segment)
	else
		table.insert(segments, index, removed_segment)
	end
end

---@param segments iron-e.plugins.tabline.Segment[]
---@param bufnr integer
local function generate_segments(segments, bufnr)
	local hl_base = Highlights.by_activity[Cache.activities_by_bufnr[bufnr]]
	local hl_default = hl_base[Cache.modified_by_byfnr[bufnr]]
	local hl_sign = hl_base.sign

	table.insert(segments, {
		hl = hl_sign,
		content = "",
	})

	table.insert(segments, { hl = hl_default, content = " " })

	local name = Cache.names_by_bufnr[bufnr] or "[No Name]"
	local icon, icon_hl = MiniIcons.get("file", name)

	table.insert(segments, {
		hl = icon_hl,
		inherit_hl = true,
		content = icon,
	})

	table.insert(segments, {
		hl = hl_default,
		content = " " .. name .. " ",
	})

	table.insert(segments, {
		hl = hl_sign,
		content = "",
	})
end

--- @class iron-e.plugins.Tabline
local M = {}

local sbuf = require("string.buffer").new()

function M.render()
	if Cache.last_statusline ~= nil then
		return Cache.last_statusline
	end

	--- @type iron-e.plugins.tabline.Segment[]
	local segments = {}

	local buffer_segment_length = 5
	local current_segment_start = nil

	for i, bufnr in ipairs(Cache.listed_bufs) do
		if bufnr == Cache.current_buf then
			current_segment_start = i * buffer_segment_length
		end

		generate_segments(segments, bufnr)
	end

	while true do
		local width = 0
		for _, segment in ipairs(segments) do
			if segment.content ~= nil then
				width = width + vim.api.nvim_strwidth(segment.content)
			end
		end

		if width <= Cache.columns then
			break
		end

		local left = current_segment_start - 1
		local right = #segments - (current_segment_start + buffer_segment_length)

		if left < right then
			splice_segment(segments, nil, width, Cache.columns)
		else
			splice_segment(segments, 1, width, Cache.columns)
			current_segment_start = current_segment_start - 1
		end
	end

	table.insert(segments, { {
		hl = "TabLineFill",
	} })

	for _, segment in ipairs(segments) do
		format(sbuf, segment)
	end

	sbuf:put("%#TabLineFill#")

	Cache.last_statusline = sbuf:get()
	return Cache.last_statusline
end

vim.api.nvim_set_option_value("tabline", "%!v:lua.require('plugins.tabline').render()", {})

return M
