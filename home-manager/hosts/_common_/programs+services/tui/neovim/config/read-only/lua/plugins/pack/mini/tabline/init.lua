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
