--[[
 ____  _             _
|  _ \| |_   _  __ _(_)_ __  ___
| |_) | | | | |/ _` | | '_ \/ __|
|  __/| | |_| | (_| | | | | \__ \
|_|   |_|\__,_|\__, |_|_| |_|___/
               |___/
--]]

require("plugins.pack")

-- SEE: https://stackoverflow.com/questions/15429236/how-to-check-if-a-module-exists-in-lua
local function module_exists(name)
	if package.loaded[name] then
		return true
	end

	for _, searcher in ipairs(package.loaders) do
		local loader = searcher(name)
		if type(loader) == "function" then
			package.preload[name] = loader
			return true
		end
	end

	return false
end

--- @type vim.pack.keyset.add
local load = {
	load = function(plug_data)
		local plugin_name = assert(plug_data.spec.name)

		vim.api.nvim_command("packadd! " .. plugin_name)

		--- @type string
		local config_name = assert(plugin_name:match("^[^%.]*"))
		if config_name:sub(1, 5) == "nvim-" then
			config_name = config_name:sub(6)
		end

		if config_name:sub(-4, -1) == "-lua" then
			config_name = config_name:sub(1, -5)
		end

		config_name = "plugins.pack." .. config_name
		pcall(require, config_name)
	end,
}

--- @type vim.pack.keyset.add
local lazy_load = {
	load = function() end,
}

--- @type vim.pack.keyset.add
local load_if_not_manpage = vim.g.man ~= true and load or lazy_load

-- load colorscheme first
vim.pack.add({
	"https://github.com/Iron-E/nvim-highlite", -- TODO: load locally
}, load)

vim.pack.add({
	"https://github.com/Iron-E/flash.nvim", -- TODO: load locally
	"https://github.com/nvim-mini/mini.nvim", -- dep (mini.icons)
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/stevearc/quicker.nvim",
	{ src = "https://github.com/dstein64/vim-win", version = "00a31b44f9388927102dcd96606e236f13681a33" },
}, load)

vim.pack.add({
	"https://github.com/rebelot/heirline.nvim", -- deps: mini.icons
}, load)

vim.pack.add({
	"https://github.com/Saghen/blink.compat", -- dep
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/NMAC427/guess-indent.nvim",
	"https://github.com/mboughaba/i3config.vim",
	"https://github.com/Iron-E/nvim-libmodal", -- dep; TODO: load locally
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/chrisgrieser/nvim-scissors",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/nvim-lua/plenary.nvim", -- dep
	"https://github.com/seblj/roslyn.nvim",
	"https://github.com/Iron-E/thethethe.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/folke/ts-comments.nvim",
	"https://github.com/tpope/vim-dadbod", -- dep
	"https://github.com/MTDL9/vim-log-highlighting",
}, load_if_not_manpage)

vim.pack.add({
	"https://github.com/stevearc/aerial.nvim", -- deps: nvim-treesitter, mini.icons
	"https://github.com/romgrk/barbar.nvim", -- deps: gitsigns.nvim, mini.icons; TODO: load locally
	{ src = "https://github.com/Saghen/blink.cmp", name = "blink-cmp", version = vim.version.range("^1") }, -- deps: mini.icons, friendly snippets
	"https://github.com/ibhagwan/fzf-lua", -- deps: mini.icons
	"https://github.com/lewis6991/gitsigns.nvim", -- deps: plenary.nvim
	"https://github.com/Iron-E/nvim-bufmode", -- deps: nvim-libmodal
	"https://github.com/Iron-E/nvim-tabmode", -- deps: nvim-libmodal
	"https://github.com/nvim-treesitter/nvim-treesitter-context", -- deps: nvim-treesitter
	"https://github.com/kristijanhusak/vim-dadbod-completion", -- deps: dadbod
	"https://github.com/kristijanhusak/vim-dadbod-ui", -- deps: dadbod
}, load_if_not_manpage)

vim.pack.add({
	"https://github.com/kdheepak/cmp-latex-symbols", -- deps: blink.cmp, blink.compat
	"https://github.com/wintermute-cell/gitignore.nvim", -- deps: fzf-lua
	"https://github.com/folke/lazydev.nvim", -- optional deps: blink.cmp
	"https://github.com/pwntester/octo.nvim", -- deps: plenary, fzf-lua, mini.icons
}, load_if_not_manpage)

-- require("plugins.lazy")
require("plugins.undotree")
require("stenvim"):register()
