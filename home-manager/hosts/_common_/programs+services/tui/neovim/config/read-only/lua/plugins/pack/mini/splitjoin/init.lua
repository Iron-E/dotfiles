local split_join = require("mini.splitjoin")
local gen_hook = split_join.gen_hook

local brace = "%b{}"
local bracket = "%b[]"
local paren = "%b()"

local all = { brackets = { brace, bracket, paren } }
local braces = { brackets = { brace } }
local not_parens = { brackets = { brace, bracket } }

split_join.setup({
	detect = {
		separator = ",",
	},

	join = {
		hooks_post = {
			gen_hook.del_trailing_separator(all),
			gen_hook.pad_brackets(braces),
		},
	},

	split = {
		hooks_post = {
			gen_hook.add_trailing_separator(not_parens),
		},
	},
})

local bvar = "minisplitjoin_config"
local group = vim.api.nvim_create_augroup("config.mini.splitjoin", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "ft-specific trailing seprator setup",
	group = group,
	pattern = {
		"gleam",
		"go",
		"jsonnet",
		"rust",
		"typescript",
		"typescriptreact",
		"typst",
	},

	callback = function(ev)
		vim.api.nvim_buf_set_var(ev.buf, bvar, {
			split = {
				hooks_post = {
					gen_hook.add_trailing_separator(all),
				},
			},
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "ft-specific trailing seprator setup",
	group = group,
	pattern = {
		"json",
		"nix",
		"sql",
	},

	callback = function(ev)
		vim.api.nvim_buf_set_var(ev.buf, bvar, {
			split = {
				hooks_post = {},
			},
		})
	end,
})
