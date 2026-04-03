vim.api.nvim_set_keymap("", "gq", "<Cmd>lua require('conform').format({ async = true })<CR>", {
	desc = "Format buffer",
})

vim.api.nvim_set_keymap("n", "<Leader>Gq", "<Cmd>ConformToggle<CR>", {})

--- @param else_ string
--- @param formatter string
--- @param bufnr integer
--- @return string
local function available_or(else_, formatter, bufnr)
	if require("conform").get_formatter_info(formatter, bufnr).available then
		return formatter
	end

	return else_
end

--- @type conform.setupOpts
local opts = {
	formatters = {
		deno_fmt = {
			require_cwd = true,
			cwd = function(_, ctx)
				return vim.fs.root(ctx.filename, { "deno.json", "deno.lock" })
			end,
		},
	},

	formatters_by_ft = {
		cs = { "csharpier" },

		css = function(bufnr)
			local formatter = available_or("prettierd", "deno_fmt", bufnr)
			return { formatter }
		end,

		gleam = { "gleam" },
		go = { "goimports", "gofmt" },

		javascriptreact = function(bufnr)
			local formatter = available_or("prettierd", "deno_fmt", bufnr)
			return { formatter, "rustywind" }
		end,

		["hcl.terragrunt"] = { "terragrunt_hclfmt" },
		["hcl.terragrunt-stack"] = { "terragrunt_hclfmt" },
		jsonnet = { "jsonnetfmt" },
		lua = { "stylua" },
		markdown = { "deno_fmt" },
		nix = { "nixfmt" },
		opentofu = { "tofu_fmt" },
		proto = { "buf" },
		rust = { "rustfmt" },
		sh = { "shellcheck", timeout_ms = 1000 },
		sql = { "deno_fmt" },
		terraform = { "terraform_fmt" },
	},

	default_format_opts = {
		lsp_format = "fallback",
	},

	format_on_save = {
		timeout_ms = 500,
	},
}

opts.formatters_by_ft.html = opts.formatters_by_ft.css
opts.formatters_by_ft.javascript = opts.formatters_by_ft.css
opts.formatters_by_ft.json = opts.formatters_by_ft.javascript
opts.formatters_by_ft.jsonc = opts.formatters_by_ft.json
opts.formatters_by_ft.less = opts.formatters_by_ft.css
opts.formatters_by_ft.sass = opts.formatters_by_ft.scss
opts.formatters_by_ft.scss = opts.formatters_by_ft.css
opts.formatters_by_ft.typescript = opts.formatters_by_ft.javascript
opts.formatters_by_ft.typescriptreact = opts.formatters_by_ft.javascriptreact
opts.formatters_by_ft.yaml = opts.formatters_by_ft.json
opts.formatters_by_ft["opentofu-vars"] = opts.formatters_by_ft.opentofu
opts.formatters_by_ft["terraform-vars"] = opts.formatters_by_ft.terraform

opts.log_level = vim.log.levels.OFF

local conform = require("conform")
conform.setup(opts)

local enabled = true
vim.api.nvim_create_user_command("ConformToggle", function()
	local toggle_opts = opts
	local log_msg = "enabled"

	if enabled then -- disable
		toggle_opts = {}
		log_msg = "disabled"
	end

	enabled = not enabled
	conform.setup(toggle_opts)
	vim.notify("conform.nvim: " .. log_msg, vim.log.levels.INFO)
end, {
	desc = "Toggle conform.nvim for all buffers.",
	nargs = 0,
})
