--- @module 'mini.trailspace'

return {
	{
		-- TODO: replace this with a short function of my own?
		"echasnovski/mini.trailspace",
		opts = function()
			local group = vim.api.nvim_create_augroup("config.mini.trailspace", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Trim last lines of buffer",
				group = group,
				callback = function(ev)
					local opts = { buf = ev.buf }
					if
						not vim.api.nvim_get_option_value("binary", opts)
						and vim.api.nvim_get_option_value("filetype", opts) ~= "diff"
					then
						MiniTrailspace.trim_last_lines()
					end
				end,
			})
		end,
	},
}
