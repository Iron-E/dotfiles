local Events = require 'stenvim.events'
local Math = require 'stenvim.math'

--- @class stenvim.UI
--- @field default_win_width integer
--- @field screen_width integer
local UI = {}

--- Get the text in a buffer.
--- @param bufnr integer
function UI.buf_text(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)
	return lines[1]
end

--- Closes windows and deletes buffers.
--- @param bufnr integer
--- @param winid integer
function UI.cleanup(bufnr, winid)
	vim.api.nvim_win_close(winid, true)
	vim.api.nvim_buf_delete(bufnr, { force = true, unload = false })
end

--- Updates the `UI.screen_width` and `UI.default_win_width` values.
function UI:refresh()
	local screen_width = vim.api.nvim_get_option_value('columns', {})
	self.screen_width = screen_width
	self.default_win_width = Math.round(screen_width * .10)
end

--- @param title_width integer
--- @param text_width integer
--- @return integer win_width
function UI:win_width(title_width, text_width)
	--- the magic numbers 4 and 2 just add right padding to the text and/or title
	--- why 4 and 2? it just seems to look good that way
	local title_or_text_width = math.max(title_width + 4, text_width + 2)
	return math.max(self.default_win_width, title_or_text_width)
end

vim.api.nvim_create_autocmd('OptionSet', {
	group = Events.augroup,
	pattern = 'columns',
	callback = function()
		UI:refresh()
	end,
})

UI:refresh()
return UI
