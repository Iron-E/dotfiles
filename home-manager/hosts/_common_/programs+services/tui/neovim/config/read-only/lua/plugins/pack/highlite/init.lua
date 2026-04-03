local allow_list = {
	__index = function()
		return false
	end,
}

require("highlite").setup({
	terminal_colors = false,
	generate = {
		syntax = setmetatable({
			dosini = true,
			editorconfig = true,
			i3config = true,
			man = true,
			plantuml = true,
		}, allow_list),

		plugins = {
			vim = setmetatable({
				dadbod_ui = true,
			}, allow_list),

			nvim = {
				leap = false,
				lspsaga = false,
				nvim_tree = false,
				packer = false,
				sniprun = false,
				symbols_outline = false,
			},
		},
	},
})

vim.api.nvim_command("colorscheme highlite-custom")
