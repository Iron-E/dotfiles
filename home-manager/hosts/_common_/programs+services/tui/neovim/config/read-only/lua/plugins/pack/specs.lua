local Pack = require("plugins.pack")
local Loader = require("plugins.pack.loader")

local load = {
	load = function(plugin)
		Loader.load_plugin(plugin.spec.name)
	end,
}

--- @type vim.pack.keyset.add
local async_load = {
	load = function(plugin)
		Loader.enqueue_plugin_load(plugin.spec.name)
	end,
}

--- @type vim.pack.keyset.add
local do_not_load = {
	load = function() end,
}

local starting_for_manpage = vim.g.man == true

--- @type vim.pack.keyset.add
local load_if_not_manpage = starting_for_manpage and do_not_load or load

--- @type vim.pack.keyset.add
local async_load_if_not_manpage = starting_for_manpage and do_not_load or async_load

--- Declare how each plugin should be built when updating
Pack.build_instructions = {
	["blink.cmp"] = function(plugin)
		-- NOTE: we could do `BlinkCmp build`, but not all systems have cargo installed
		local on_out = function(err, data)
			if err then
				vim.notify("[blink.cmp build] " .. err, vim.log.levels.WARN)
				return
			end

			if data then
				vim.notify("[blink.cmp build] " .. data, vim.log.levels.INFO)
			end
		end

		vim.system({ "nix", "run", ".#build-plugin" }, {
			cwd = plugin.path,
			text = true,
			timeout = 60000 * 10, -- ten minute
			stdout = on_out,
			stderr = on_out,
		}, function(obj)
			if obj.code == 0 then
				vim.notify("[blink.cmp build] completed", vim.log.levels.INFO)
				return
			end

			vim.notify("[blink.cmp build] exit code " .. obj.code, vim.log.levels.ERROR)
		end)
	end,

	["nvim-treesitter"] = function()
		vim.api.nvim_command("TSUpdate")
	end,
}

-- TODO: most of these calls could be combined, once the order of vim.pack.add events is enforced.

-- load colorscheme first
vim.pack.add({
	"https://github.com/Iron-E/nvim-highlite",
}, load)

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim", -- dep (mini.icons)
}, load)

vim.pack.add({
	"https://github.com/Iron-E/flash.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/stevearc/quicker.nvim",
}, async_load)

vim.pack.add({
	"https://github.com/rebelot/heirline.nvim", -- deps: mini.icons
}, load)

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lua/plenary.nvim", -- dep
}, load_if_not_manpage)

vim.pack.add({
	"https://github.com/seblj/roslyn.nvim",
}, {
	load = function(plugin)
		Loader.load_plugin_on(plugin.spec.name, "FileType", "cs")
	end,
})

vim.pack.add({
	"https://github.com/Saghen/blink.compat", -- dep
	"https://github.com/rafamadriz/friendly-snippets", -- dep-ish
	"https://github.com/NMAC427/guess-indent.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, load_if_not_manpage)

vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mboughaba/i3config.vim",
	"https://github.com/Iron-E/nvim-libmodal", -- dep
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/chrisgrieser/nvim-scissors",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/folke/ts-comments.nvim",
	"https://github.com/tpope/vim-dadbod", -- dep
	"https://github.com/MTDL9/vim-log-highlighting",
}, async_load_if_not_manpage)

vim.pack.add({
	"https://github.com/Iron-E/thethethe.nvim",
}, {
	load = function(plugin)
		if not starting_for_manpage then
			Loader.load_plugin_on(plugin.spec.name, "InsertEnter")
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("^1") }, -- deps: mini.icons, friendly snippets
	"https://github.com/lewis6991/gitsigns.nvim", -- deps: plenary.nvim
}, load_if_not_manpage)

vim.pack.add({
	"https://github.com/stevearc/aerial.nvim", -- deps: nvim-treesitter, mini.icons
	"https://github.com/ibhagwan/fzf-lua", -- deps: mini.icons
	"https://github.com/Iron-E/nvim-bufmode", -- deps: nvim-libmodal
	"https://github.com/Iron-E/nvim-tabmode", -- deps: nvim-libmodal
	"https://github.com/nvim-treesitter/nvim-treesitter-context", -- deps: nvim-treesitter
	"https://github.com/kristijanhusak/vim-dadbod-completion", -- deps: dadbod
	"https://github.com/kristijanhusak/vim-dadbod-ui", -- deps: dadbod
}, async_load_if_not_manpage)

vim.pack.add({
	"https://github.com/kdheepak/cmp-latex-symbols", -- deps: blink.cmp, blink.compat
}, {
	load = function(plugin)
		if not starting_for_manpage then
			Loader.load_plugin_on(plugin.spec.name, "FileType", { "latex", "markdown" })
		end
	end,
})

vim.pack.add({
	"https://github.com/folke/lazydev.nvim", -- optional deps: blink.cmp
}, {
	load = function(plugin)
		if not starting_for_manpage then
			Loader.load_plugin_on(plugin.spec.name, "FileType", "lua")
		end
	end,
})

vim.pack.add({
	"https://github.com/wintermute-cell/gitignore.nvim", -- deps: fzf-lua
	"https://github.com/pwntester/octo.nvim", -- deps: plenary, fzf-lua, mini.icons
}, async_load_if_not_manpage)
