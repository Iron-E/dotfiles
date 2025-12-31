--- @module 'lazy'

--- @type LazySpec[]
return {
	{
		"stevearc/conform.nvim",
		cmd = {
			"ConformInfo",
			"ConformToggle",
		},

		event = "BufWritePre",

		keys = {
			{
				"gq",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
			{ "<Leader>Gq", "<Cmd>ConformToggle<CR>", mode = "n" },
		},

		config = function(_, opts)
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
		end,

		--- @param o conform.setupOpts
		opts = function(_, o)
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

			o.formatters_by_ft = {
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

				jsonnet = { "jsonnetfmt" },
				nix = { "nixfmt" },
				opentofu = { "tofu_fmt" },
				proto = { "buf" },
				rust = { "rustfmt" },
				sh = { "shellcheck" },
				sql = { "deno_fmt" },
				terraform = { "terraform_fmt" },
			}

			o.formatters_by_ft.html = o.formatters_by_ft.css
			o.formatters_by_ft.javascript = o.formatters_by_ft.css
			o.formatters_by_ft.json = o.formatters_by_ft.javascript
			o.formatters_by_ft.jsonc = o.formatters_by_ft.json
			o.formatters_by_ft.less = o.formatters_by_ft.css
			o.formatters_by_ft.markdown = o.formatters_by_ft.html
			o.formatters_by_ft.sass = o.formatters_by_ft.scss
			o.formatters_by_ft.scss = o.formatters_by_ft.css
			o.formatters_by_ft.typescript = o.formatters_by_ft.javascript
			o.formatters_by_ft.typescriptreact = o.formatters_by_ft.javascriptreact
			o.formatters_by_ft.yaml = o.formatters_by_ft.json
			o.formatters_by_ft["opentofu-vars"] = o.formatters_by_ft.opentofu
			o.formatters_by_ft["terraform-vars"] = o.formatters_by_ft.terraform

			o.format_on_save = function(bufnr)
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
				if filetype == "lua" then
					return nil
				elseif filetype == "sh" then -- shellcheck can take a while
					return { timeout_ms = 1000 }
				end

				--- @type conform.FormatOpts
				return { timeout_ms = 500 }
			end

			o.formatters = {
				deno_fmt = {
					require_cwd = true,
					cwd = function(_, ctx)
						return vim.fs.root(ctx.filename, { "deno.json", "deno.lock" })
					end,
				},
				yq = {
					args = { "-y" },
				},
			}

			o.log_level = vim.log.levels.OFF
		end,
	},
}
