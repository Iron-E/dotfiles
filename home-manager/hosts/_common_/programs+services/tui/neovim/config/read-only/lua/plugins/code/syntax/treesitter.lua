--- the known-available parsers
--- @type { [string]: true }
local available_parsers = {}

--- the known-installed parsers
--- @type { [string]: true|async.Task }
local installed_parsers = {}

--- @param install fun(parsers: string[]): async.Task
--- @param parsers string[]
--- @return async.Task
local function install_parsers(install, parsers)
	local task = install(parsers)
	for _, parser in ipairs(parsers) do
		installed_parsers[parser] = task
	end

	task:await(function()
		for _, parser in ipairs(parsers) do
			installed_parsers[parser] = true
		end
	end)

	return task
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",

		cond = vim.g.man ~= true,
		event = vim.g.lazy_event_file_read,

		cmd = {
			"TSInstall",
			"TSInstallFromGrammar",
			"TSLog",
			"TSUninstall",
			"TSUpdate",
		},

		init = function()
			local ts_utils = require("ts_utils") --- @type config.TSUtils
			vim.api.nvim_create_user_command("ShowAs", function(tbl)
				local file_ext, node_type = unpack(tbl.fargs)
				local node = ts_utils.get_next_ancestor(node_type)
				if node == nil then
					return vim.notify("No " .. node_type .. " at cursor", vim.log.levels.INFO)
				end

				ts_utils.in_floating_window(node, file_ext)
			end, { complete = "filetype", desc = "Show $2 TS node in float with $1 file extension ", nargs = "+" })

			vim.api.nvim_create_autocmd("FileType", {
				desc = "Auto-install parsers for each buffer",
				group = "config",
				callback = function(ev)
					local ft = ev.match
					local lang = vim.treesitter.language.get_lang(ft)
					if available_parsers[lang] == nil then
						return
					end

					local installed = installed_parsers[lang]
					if installed == true then -- already installed
						return
					end

					local task = installed
					if task == nil then
						local ts = require("nvim-treesitter")
						task = install_parsers(ts.install, { lang })
					end

					-- re-trigger filetype detection to attach highlighting
					local win = vim.api.nvim_get_current_win()
					task:await(function()
						vim.api.nvim_command("TSWinEnable " .. win .. " " .. ev.buf)
					end)
				end,
			})
		end,
		config = function(_, o)
			local ts = require("nvim-treesitter")

			local available = ts.get_available()
			for _, parser in ipairs(available) do
				available_parsers[parser] = true
			end

			local installed = ts.get_installed("parsers")
			for _, parser in ipairs(installed) do
				installed_parsers[parser] = true
				o.ensure_installed[parser] = nil
			end

			if vim.tbl_isempty(o.ensure_installed) then -- no parsers to install
				return
			end

			install_parsers(ts.install, o.ensure_installed)
		end,
		opts = function(_, o)
			o.ensure_installed = {
				-- won't get auto installed
				"diff",
				"http",
				"markdown_inline",
				"printf",
				"regex",

				-- I maintain queries for these languages
				"bash",
				"c",
				"c_sharp",
				"css",
				"devicetree",
				"dockerfile",
				"fish",
				"git_config",
				"gitignore",
				"git_rebase",
				"gleam",
				"go",
				"gomod",
				"gotmpl",
				"html",
				"ini",
				"java",
				"javascript",
				"jq",
				"jsonnet",
				"lua",
				"markdown",
				"mermaid",
				"nix",
				"proto",
				"python",
				"query",
				"rust",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"typst",
				"ungrammar",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			}
		end,
	},
}
