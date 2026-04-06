--- the known-available parsers
--- @type { [string]: true }
local available_parsers = {}

--- the known-installed parsers
--- @type { [string]: true|async.Task }
local installed_parsers = {}

local ensure_installed = {
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

local ts = require("nvim-treesitter")

do
	local available = ts.get_available()
	for _, parser in ipairs(available) do
		available_parsers[parser] = true
	end

	local installed = ts.get_installed("parsers")
	for _, parser in ipairs(installed) do
		installed_parsers[parser] = true
		ensure_installed[parser] = nil
	end
end

install_parsers(ts.install, ensure_installed)

--- @param buf integer
--- @param ft string
local function install_parsers_for_ft(buf, ft)
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
		task = install_parsers(ts.install, { lang })
	end

	local win = vim.fn.bufwinid(buf)
	task:await(function()
		vim.api.nvim_command("TSWinEnable " .. win .. " " .. buf)
	end)
end

local group = vim.api.nvim_create_augroup("config.treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "Auto-install parsers for each buffer",
	group = group,
	callback = function(ev)
		install_parsers_for_ft(ev.buf, ev.match)
	end,
})

-- if vim already entered when this was sourced,
-- then we missed the FT events for the files that were opened at startup.
if vim.v.vim_did_init == 1 then
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
			install_parsers_for_ft(buf, ft)
		end
	end
end

-----------------------------

local ts_utils = require("ts_utils") --- @type config.TSUtils
vim.api.nvim_create_user_command("ShowAs", function(tbl)
	local file_ext, node_type = unpack(tbl.fargs)
	local node = ts_utils.get_next_ancestor(node_type)
	if node == nil then
		return vim.notify("No " .. node_type .. " at cursor", vim.log.levels.INFO)
	end

	ts_utils.in_floating_window(node, file_ext)
end, { complete = "filetype", desc = "Show $2 TS node in float with $1 file extension ", nargs = "+" })
