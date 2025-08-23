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

return {{ 'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	build = ':TSUpdate',

	cond = vim.g.man ~= true,
	event = vim.g.lazy_event_file_read,

	cmd = {
		'TSInstall',
		'TSInstallFromGrammar',
		'TSLog',
		'TSUninstall',
		'TSUpdate',
	},

	init = function()
		local ts_utils = require 'ts_utils' --- @type config.TSUtils
		vim.api.nvim_create_user_command('ShowAs',
			function(tbl)
				local file_ext, node_type = unpack(tbl.fargs)
				local node = ts_utils.get_next_ancestor(node_type)
				if node == nil then
					return vim.notify('No ' .. node_type .. ' at cursor', vim.log.levels.INFO)
				end

				ts_utils.in_floating_window(node, file_ext)
			end,
			{ complete = 'filetype', desc = 'Show $2 TS node in float with $1 file extension ', nargs = '+' }
		);

		vim.api.nvim_create_autocmd('FileType', {
			desc = 'Auto-install parsers for each buffer',
			group = 'config',
			callback = function(ev)
				local ft = ev.match
				local installed = installed_parsers[ft]

				if installed == true then -- already installed
					return
				end

				local task = installed
				if task == nil then
					local ts = require 'nvim-treesitter'
					task = install_parsers(ts.install, { ft })
				end

				-- re-trigger filetype detection to attach highlighting
				local win = vim.api.nvim_get_current_win()
				task:await(function()
					vim.api.nvim_command('TSWinEnable ' .. win .. ' ' .. ev.buf)
				end)
			end,
		})
	end,
	config = function(_, o)
		local ts = require 'nvim-treesitter'

		local installed = ts.get_installed('parsers')
		for _, parser in ipairs(installed) do
			installed_parsers[parser] = true
			o.ensure_installed[parser] = nil
		end

		if vim.tbl_isempty(o.ensure_installed) then -- no parsers to install
			return
		end

		local to_install = {}
		for parser, _ in pairs(o.ensure_installed) do
			table.insert(to_install, parser)
		end

		install_parsers(ts.install, to_install)
	end,
	opts = function(_, o)
		o.ensure_installed = {
			-- won't get auto installed
			diff = true,
			http = true,
			markdown_inline = true,
			printf = true,
			regex = true,

			-- I maintain queries for these languages
			bash = true,
			c = true,
			c_sharp = true,
			css = true,
			devicetree = true,
			dockerfile = true,
			fish = true,
			git_config = true,
			gitignore = true,
			git_rebase = true,
			gleam = true,
			go = true,
			gomod = true,
			gotmpl = true,
			html = true,
			ini = true,
			java = true,
			javascript = true,
			jq = true,
			jsonnet = true,
			lua = true,
			markdown = true,
			mermaid = true,
			nix = true,
			proto = true,
			python = true,
			query = true,
			rust = true,
			sql = true,
			terraform = true,
			toml = true,
			tsx = true,
			typescript = true,
			typst = true,
			ungrammar = true,
			vim = true,
			vimdoc = true,
			xml = true,
			yaml = true,
		}
	end,
}}
