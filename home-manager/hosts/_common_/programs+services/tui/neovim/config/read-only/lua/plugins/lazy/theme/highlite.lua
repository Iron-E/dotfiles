return {
	{
		"Iron-E/nvim-highlite",
		priority = math.huge,
		config = function(_, o)
			require("highlite").setup(o)
			vim.api.nvim_command("colorscheme highlite-custom")
		end,
		opts = function(_, o)
			local allow_list = {
				__index = function()
					return false
				end,
			}
			o.terminal_colors = false
			o.generate = {
				syntax = setmetatable(
					{ dosini = true, editorconfig = true, i3config = true, man = true, plantuml = true },
					allow_list
				),
				plugins = {
					vim = setmetatable({ dadbod_ui = true }, allow_list),
					nvim = {
						leap = false,
						lspsaga = false,
						nvim_tree = false,
						packer = false,
						sniprun = false,
						symbols_outline = false,
					},
				},
			}
		end,
	},
}
