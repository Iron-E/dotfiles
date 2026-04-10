require("mini.tabline").setup({
	format = function(bufnr, label)
		local buf_name = vim.api.nvim_buf_get_name(bufnr)
		local icon, _ = MiniIcons.get("file", buf_name)

		local modified = ""
		if vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
			modified = "[+]"
		end

		return string.format("▎ %s %s %s ", icon, label, modified)
	end,
})
local function buf_is_listed(bufnr)
	return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
end

-- don't show my statusline unless is is because of the autocmd below
vim.api.nvim_set_option_value("showtabline", 0, {})

-- TODO: this can probably be separated out into create and destroy events.
--       create events don't need to check for hiding the tabline, destroy events don't need to check
--       for showing it?
local group = vim.api.nvim_create_augroup("config.mini.tabline", { clear = true })
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "TabClosed", "TabNew" }, {
	desc = "Hide tabline when only one buffer open",
	group = group,
	callback = function()
		local value = 0
		if
			#vim.api.nvim_list_tabpages() > 1
			or #vim.iter(ipairs(vim.api.nvim_list_bufs())):filter(buf_is_listed):totable() > 1
		then
			value = 2
		end

		vim.api.nvim_set_option_value("showtabline", value, {})
	end,
})
