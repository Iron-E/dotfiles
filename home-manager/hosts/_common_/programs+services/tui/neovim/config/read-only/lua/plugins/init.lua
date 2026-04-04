--[[
 ____  _             _
|  _ \| |_   _  __ _(_)_ __  ___
| |_) | | | | |/ _` | | '_ \/ __|
|  __/| | |_| | (_| | | | | \__ \
|_|   |_|\__,_|\__, |_|_| |_|___/
               |___/
--]]

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
		local config_name = assert(plugin_name:match("^[^.]*"))
		if config_name:sub(1, 5) == "nvim-" then
			config_name = config_name:sub(6)
		end

		config_name = "plugins.pack." .. config_name

		if module_exists(config_name) then
			require(config_name)
		end
	end,
}

--- @type vim.pack.keyset.add
local lazy_load = {
	load = function() end,
}

--- @type vim.pack.keyset.add
local load_if_not_manpage = vim.g.man ~= true and load or lazy_load

-- TODO: migrate build instructions

local group = vim.api.nvim_create_augroup("config.pack", { clear = true })
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Run build hooks for packages",
	group = group,
	callback = function(ev)
		local name = ev.data.spec.name
		if name == "blink.cmp" then
			vim.api.nvim_command("packadd blink.cmp")
			vim.api.nvim_command("BlinkCmp build")
		elseif name == "nvim-treesitter" then
			vim.api.nvim_command("packadd nvim-treesitter")
			vim.api.nvim_command("TSUpdate")
		end
	end,
})

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
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("^1") }, -- deps: mini.icons, friendly snippets
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

--- @return string[]
local function get_package_names()
	local plugins = vim.pack.get(nil, { info = false })

	return vim.iter(ipairs(plugins))
		:map(function(_, plugin)
			return plugin.spec.name
		end)
		:totable()
end

vim.api.nvim_create_user_command("PackClean", function()
	local plugins = vim.pack.get(nil, { info = false })

	local active_plugin_names = {}
	for _, plugin in ipairs(plugins) do
		if not plugin.active then
			table.insert(active_plugin_names, plugin.spec.name)
		end
	end

	vim.pack.del(active_plugin_names)
end, {
	desc = "Clean inactive packages",
})

vim.api.nvim_create_user_command("PackRestore", function(args)
	local fargs
	if #args.fargs > 0 then
		fargs = args.fargs
	end

	vim.pack.update(fargs, { target = "lockfile" })
end, {
	desc = "Restore a package to its lockfile version",
	nargs = "?",
	complete = get_package_names,
})

vim.api.nvim_create_user_command("PackUpdate", function(args)
	local fargs
	if #args.fargs > 0 then
		fargs = args.fargs
	end

	vim.pack.update(fargs)
end, {
	desc = "Clean inactive packages",
	nargs = "?",
	complete = get_package_names,
})
