--- @class stenvim
local stenvim = {
	old_input_fn = vim.ui.input,
}

function stenvim:register()
	--- @param opts vim.ui.input.opts
	--- @param on_confirm vim.ui.input.on_confirm
	--- @diagnostic disable-next-line duplicate-field
	vim.ui.input = function(opts, on_confirm)
		require('stenvim.input'):input(opts, on_confirm)
	end
end

function stenvim:deregister()
	--- @diagnostic disable-next-line duplicate-field
	vim.ui.input = self.old_input_fn
end

stenvim:register()

return stenvim
