-- don't show my statusline unless is is because of the autocmd below
vim.api.nvim_set_option_value("showtabline", 0, {})

local function at_least_two_listed_buffers()
	local count = 0
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
			count = count + 1

			if count > 1 then
				return true
			end
		end
	end

	return false
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "TabClosed", "TabNew", "VimEnter" }, {
	desc = "Hide tabline when only one buffer open",
	group = "config.tabline",
	callback = vim.schedule_wrap(function()
		local showtabline = 0
		if vim.fn.tabpagenr("$") > 1 or at_least_two_listed_buffers() then
			showtabline = 2
		end

		vim.api.nvim_set_option_value("showtabline", showtabline, {})
	end),
})
