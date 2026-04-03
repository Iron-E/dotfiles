--- @module 'mini.icons'

local group = vim.api.nvim_create_augroup("config.aerial", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	desc = "Fix folds in aerial",
	group = group,
	pattern = "aerial",
	command = "set foldmethod=manual",
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Fix shadowing gO",
	group = group,
	pattern = "help",
	command = "unmap <buffer> gO",
})

vim.api.nvim_set_keymap("n", "gO", "<Cmd>AerialToggle<CR>", {
	desc = "Toggle aerial.nvim",
})

-- HACK: neovim provides gO as a builtin on markdown files, so we must override it.
--       nvim_buf_del_keymap works but throws an error.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Override gO in markdown",
	group = group,
	pattern = "markdown",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "gO", "<Cmd>AerialToggle<CR>", {
			desc = "Toggle aerial.nvim",
		})
	end,
})

local opts = {
	backends = { "lsp", "treesitter", "man", "markdown" },
	filter_kind = false,
	icons = {},

	layout = {
		default_direction = "right",
		max_width = { 40, 0.25 },
	},

	guides = {
		last_item = "└─ ",
		mid_item = "├─ ",
		nested_top = "│  ",
		whitespace = "   ",
	},

	keymaps = {
		["?"] = false,
		["[["] = "actions.prev",
		["[]"] = "actions.prev_up",
		["]["] = "actions.next_up",
		["]]"] = "actions.next",
	},

	show_guides = true,
}

do
	local icons = {
		"Array",
		"Class",
		"Constructor",
		"Enum",
		"EnumMember",
		"Event",
		"Field",
		"File",
		"Function",
		"Interface",
		"Key",
		"Method",
		"Module",
		"Namespace",
		"Object",
		"Operator",
		"Package",
		"Property",
		"Struct",
	}

	for _, v in ipairs(icons) do
		local icon = MiniIcons.get("lsp", v)
		opts.icons[v .. "Collapsed"] = icon .. " "
	end
end

require("aerial").setup(opts)
