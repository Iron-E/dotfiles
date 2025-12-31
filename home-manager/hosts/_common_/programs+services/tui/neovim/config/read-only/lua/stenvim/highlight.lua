local UI = require("stenvim.ui")

--- @class stenvim.Highlight
local Highlight = {
	ns = vim.api.nvim_create_namespace("stenvim"),
}

--- Clears the highlights for a buffer.
--- @param bufnr integer
function Highlight:buf_clear(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, self.ns, 0, -1)
end

-- Highlights a buffer with the `highlight_fn`
--- @param bufnr integer
--- @param highlight_fn? vim.ui.input.highlight
--- @return string text
function Highlight:buf_apply_with(bufnr, highlight_fn)
	local text = UI.buf_text(bufnr)

	if highlight_fn ~= nil then
		local highlights = highlight_fn(text)

		self:buf_clear(bufnr)
		for _, highlight in ipairs(highlights) do
			local start, stop, group = unpack(highlight)
			vim.hl.range(bufnr, Highlight.ns, group, { 0, start }, { 1, stop }, {})
		end
	end

	return text
end

return Highlight
