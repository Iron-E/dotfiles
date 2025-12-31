--- @class stenvim.Events
local Events = {
	augroup = vim.api.nvim_create_augroup("stenvim", {
		clear = true,
	}),
}

return Events
