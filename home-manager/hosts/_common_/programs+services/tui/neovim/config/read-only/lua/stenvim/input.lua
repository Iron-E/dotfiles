local Events = require("stenvim.events")
local Func = require("stenvim.func")
local Highlight = require("stenvim.highlight")
local UI = require("stenvim.ui")

--- @class stenvim.Input
--- @field completefunc fun(findstart: 0|1, base: string): integer|string[]
--- @field protected prompt_width integer
local Input = {
	prompt_width = 0,
}

function Input.enter_append_mode()
	vim.api.nvim_input("A")
end

function Input.enter_normal_mode()
	vim.api.nvim_input("<Esc>")
end

--- Sets the `Input.completefunc` for the given `completion` settings.
--- It does **not** update buffers to use the newly-set completion source.
--- @param completion vim.ui.input.completion
function Input.set_completefunc(completion)
	if completion == nil then
		function Input.completefunc(findstart, base)
			if findstart == 1 then
				return 0
			end

			return {}
		end

		return
	end

	function Input.completefunc(findstart, base)
		if findstart == 1 then
			return 0
		end

		return vim.fn.getcompletion(base, completion)
	end
end

--- Create all buffer-local autocommands which will be used for the input dialogue.
--- @param bufnr integer
--- @param winid integer
--- @param on_confirm vim.ui.input.on_confirm
--- @param highlight_fn? vim.ui.input.highlight
function Input:setup_autocmds(bufnr, winid, on_confirm, highlight_fn)
	vim.api.nvim_create_autocmd({ "BufDelete", "BufHidden", "BufLeave", "BufUnload", "BufWipeout" }, {
		desc = "Cleanup vim.ui.input",
		group = Events.augroup,
		buffer = bufnr,
		once = true,
		callback = vim.schedule_wrap(function()
			if vim.api.nvim_buf_is_valid(bufnr) then
				UI.cleanup(bufnr, winid)
				on_confirm()
			end
		end),
	})

	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		desc = "Resize popup",
		group = Events.augroup,
		buffer = bufnr,
		callback = function()
			local text = Highlight:buf_apply_with(bufnr, highlight_fn)
			local text_width = vim.api.nvim_strwidth(text)
			local win_width = UI:win_width(self.prompt_width, text_width)
			vim.api.nvim_win_set_width(winid, win_width)
		end,
	})
end

--- Set completion options for the buffer of the input dialogue.
function Input:setup_completion(bufnr)
	local completefunc = 'v:lua.require("stenvim.input").completefunc'

	--- @type vim.api.keyset.option
	local opts = { buf = bufnr }

	vim.api.nvim_set_option_value("completefunc", completefunc, opts)
	vim.api.nvim_set_option_value("omnifunc", completefunc, opts)
end

--- Create all buffer-local mappings which will be used for the input dialogue.
--- @param bufnr integer
--- @param winid integer
--- @param on_confirm vim.ui.input.on_confirm
function Input:setup_mappings(bufnr, winid, on_confirm)
	for _, mode in ipairs({ "n", "i" }) do
		vim.api.nvim_buf_set_keymap(bufnr, mode, "<Enter>", "", {
			desc = "Confirm input",
			callback = function()
				local text = UI.buf_text(bufnr)
				on_confirm(text)
				UI.cleanup(bufnr, winid)
			end,
		})
	end

	--- @type vim.keymap.set.Opts
	local opts = {
		desc = "Cacnel vim.ui.input",
		callback = function()
			on_confirm()
			UI.cleanup(bufnr, winid)
		end,
	}

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", "", opts)
	-- NOTE: should be <C-c>, but that clashes with my blink mappings
	vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-d>", "", opts)
end

--- @param opts vim.ui.input.opts
--- @param on_confirm vim.ui.input.on_confirm
--- @see vim.ui.input
function Input:input(opts, on_confirm)
	local bufnr = vim.api.nvim_create_buf(false, true)

	local default_text_width = 0
	if opts.default then
		vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { opts.default })
		default_text_width = vim.api.nvim_strwidth(opts.default)
	end

	if opts.prompt then
		self.prompt_width = vim.api.nvim_strwidth(opts.prompt)
	else
		self.prompt_width = 0
	end

	local win_width = UI:win_width(self.prompt_width, default_text_width)
	local winid = vim.api.nvim_open_win(bufnr, true, {
		title = opts.prompt,
		style = "minimal",
		relative = "cursor",
		row = 1,
		col = -1,
		height = 1,
		width = win_width,
	})

	self.set_completefunc(opts.completion)

	on_confirm = Func.map(on_confirm, self.enter_normal_mode)

	self:setup_autocmds(bufnr, winid, on_confirm, opts.highlight)
	self:setup_completion(bufnr)
	self:setup_mappings(bufnr, winid, on_confirm)

	self.enter_append_mode()
end

return Input
