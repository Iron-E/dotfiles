--- @module 'fzf-lua'
--- @module 'lazy'

vim.api.nvim_set_keymap("n", "<A-b>", "<Cmd>FzfLua buffers<CR>", {})
vim.api.nvim_set_keymap("n", "<A-f>", "<Cmd>FzfLua files<CR>", {})
vim.api.nvim_set_keymap("n", "<A-w>d", "<Cmd>FzfLua diagnostics_document<CR>", {})
vim.api.nvim_set_keymap("n", "<A-w><A-d>", "<Cmd>FzfLua diagnostics_workspace<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>F", "<Cmd>FzfLua resume<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>f", "<Cmd>FzfLua<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>g", "<Cmd>FzfLua live_grep<CR>", {})
vim.api.nvim_set_keymap("n", "z=", "<Cmd>FzfLua spell_suggest<CR>", {})

vim.api.nvim_create_user_command("OCITags", function(args)
	local oci = require("plugins.pack.fzf.oci")
	if args.bang then
		oci.tags()
		return
	end

	oci.live_tags()
end, { force = true, bang = true })

---@param bufnr integer
local function setup_keymaps(bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>FzfLua lsp_definitions<CR>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>FzfLua lsp_declarations<CR>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<Cmd>FzfLua lsp_implementations<CR>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>FzfLua lsp_references<CR>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gw", "<Cmd>FzfLua lsp_document_symbols<CR>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gW", "<Cmd>FzfLua lsp_live_workspace_symbols<CR>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gy", "<Cmd>FzfLua lsp_typedefs<CR>", {})

	-- this probably looks backwards, but it is more orthogonal to the tag/jump stack mappings
	vim.api.nvim_buf_set_keymap(bufnr, "n", "g<C-o>", "<Cmd>FzfLua lsp_incoming_calls<CR>", {
		desc = "Outer callstack",
	})

	vim.api.nvim_buf_set_keymap(bufnr, "n", "g<C-i>", "<Cmd>FzfLua lsp_outgoing_calls<CR>", {
		desc = "Inner callstack",
	})
end

local group = vim.api.nvim_create_augroup("config.fzf-lua", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Set up buffer local mappings",
	group = group,
	callback = function(event)
		setup_keymaps(event.buf)
	end,
})

if vim.v.vim_did_enter == 1 then
	local clients = vim.lsp.get_clients()
	local bufnrs = {}
	for _, client in ipairs(clients) do
		for bufnr, _ in pairs(client.attached_buffers) do
			bufnrs[bufnr] = true
		end
	end

	for bufnr, _ in pairs(bufnrs) do
		setup_keymaps(bufnr)
	end
end

--- @diagnostic disable-next-line:duplicate-set-field
vim.ui.select = function(...)
	vim.api.nvim_command(
		"FzfLua register_ui_select winopts.width=0.33 winopts.height=0.33 winopts.relative=cursor winopts.row=1 winopts.col=3"
	)

	vim.ui.select(...)
end

local fzf = require("fzf-lua")

--- @type fzf-lua.Config
local opts = {
	{ "fzf-native", "hide" },

	keymap = {
		builtin = {
			["<M-Esc>"] = "abort",
			["<F1>"] = "toggle-help",
			["<F2>"] = "toggle-fullscreen",
			-- Only valid with the 'builtin' previewer
			["<F3>"] = "toggle-preview-wrap",
			["<F4>"] = "toggle-preview",
			-- Rotate preview clockwise/counter-clockwise
			["<F5>"] = "toggle-preview-ccw",
			["<F6>"] = "toggle-preview-cw",
			-- `ts-ctx` binds require `nvim-treesitter-context`
			["<F7>"] = "toggle-preview-ts-ctx",
			["<F8>"] = "preview-ts-ctx-dec",
			["<F9>"] = "preview-ts-ctx-inc",
			["<A-l>"] = "preview-reset",
			["<A-d>"] = "preview-page-down",
			["<A-u>"] = "preview-page-up",
			["<A-j>"] = "preview-down",
			["<A-k>"] = "preview-up",
		},

		-- Use FZF_DEFAULT_OPTS_FILE
		fzf = {},
	},

	actions = {
		-- Pickers inheriting these actions:
		--   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
		--   tags, btags, args, buffers, tabs, lines, blines
		files = {
			["enter"] = fzf.actions.file_edit_or_qf,
			["ctrl-s"] = fzf.actions.file_split,
			["ctrl-x"] = fzf.actions.file_vsplit,
			["ctrl-t"] = fzf.actions.file_tabedit,
			["alt-q"] = fzf.actions.file_sel_to_qf,
			["alt-Q"] = fzf.actions.file_sel_to_ll,
			["alt-i"] = fzf.actions.toggle_ignore,
			["alt-h"] = fzf.actions.toggle_hidden,
			["alt-f"] = fzf.actions.toggle_follow,
		},
	},

	fzf_opts = {
		["--keep-right"] = false,
	},

	files = {
		fzf_opts = {
			["--keep-right"] = true,
		},
	},

	grep = {
		RIPGREP_CONFIG_PATH = vim.uv.os_getenv("RIPGREP_CONFIG_PATH"),
	},
}

fzf.setup(opts)
