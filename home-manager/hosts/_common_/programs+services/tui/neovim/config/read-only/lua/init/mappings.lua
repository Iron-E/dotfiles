--[[
 __  __                   _
|  \/  |                 (_)
| \  / | __ _ _ __  _ __  _ _ __   __ _ ___
| |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
| |  | | (_| | |_) | |_) | | | | | (_| \__ \
|_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
             | |   | |             __/ |
             |_|   |_|            |___/
--]]
vim.g.mapLeader = "\\"

local no_opts = {}
local noremap = { noremap = true }

--[[
   __  ____
  /  |/  (_)__ ____
 / /|_/ / (_-</ __/
/_/  /_/_/___/\__/
--]]

-- Do not jump snippets on tab
vim.api.nvim_set_keymap("i", "<Tab>", "<Tab>", noremap)
vim.api.nvim_set_keymap("s", "<Tab>", "<Tab>", noremap)

vim.api.nvim_set_keymap("i", "<C-S-i>", "<Cmd>!zcw fzu<CR>", noremap)

-- Make `p` in visual mode not overwrite the unnamed register by default. `P` now does that.
vim.api.nvim_set_keymap("x", "p", "P", noremap)
vim.api.nvim_set_keymap("x", "P", "p", noremap)

-- Sort selected text
vim.api.nvim_set_keymap("x", "<Leader>s", ":sort iu<CR>", no_opts)

--[[
   ____              _
  / __/__  ___ _____(_)__  ___ _
 _\ \/ _ \/ _ `/ __/ / _ \/ _ `/
/___/ .__/\_,_/\__/_/_//_/\_, /
   /_/                   /___/
--]]

vim.api.nvim_set_keymap("n", "<Leader><C-v>", "<Cmd>TogglePaste<CR>", {})

-- Reset kerning
vim.api.nvim_set_keymap("", "<Leader>rk", "kJi<C-m><Esc>", noremap)

-- Copy to clipboard
vim.api.nvim_set_keymap("n", "<Leader>%", "<Cmd>%y+<CR>", noremap)
vim.api.nvim_set_keymap("n", "<Leader>Y", '"+y$', noremap)
vim.keymap.set({ "x", "n" }, "<Leader>y", '"+y')

-- Paste from clipboard
vim.api.nvim_set_keymap("n", "<Leader>p", "a<C-r>+<Esc>", noremap)
vim.api.nvim_set_keymap("n", "<Leader>P", "A<C-r>+<Esc>", noremap)

-- Move lines visually rather than logically
vim.api.nvim_set_keymap("", "<C-j>", "gj", noremap)
vim.api.nvim_set_keymap("", "<C-k>", "gk", noremap)

-- insert with space before
vim.api.nvim_set_keymap("n", "<A-S-i>", "", {
	callback = function()
		vim.api.nvim_input("I<Space><Left>")
	end,
})

vim.api.nvim_set_keymap("n", "<A-i>", "", {
	callback = function()
		vim.api.nvim_input("i<Space><Left>")
	end,
})

-- Toggle concealing
vim.api.nvim_set_keymap("n", "<Leader>c", "<Cmd>ToggleWinConcealLevel<CR>", {})

--[[
  ____       __  _
 / __ \___  / /_(_)__  ___  ___
/ /_/ / _ \/ __/ / _ \/ _ \(_-<
\____/ .__/\__/_/\___/_//_/___/
    /_/
--]]

-- Toggle linewrap
vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>ToggleWinWrap<CR>", {})

-- Toggle Spellcheck
vim.api.nvim_set_keymap("n", "<Leader>s", "<Cmd>ToggleWinSpell<CR>", {})

vim.api.nvim_set_keymap("n", "<Leader>m", "<Cmd>ToggleMouse<CR>", {})

--[[
 _      ___         __
| | /| / (_)__  ___/ /__ _    _____
| |/ |/ / / _ \/ _  / _ \ |/|/ (_-<
|__/|__/_/_//_/\_,_/\___/__,__/___/
--]]

-- close window
vim.api.nvim_set_keymap("n", "<A-q>", "<Cmd>quit<CR>", no_opts)

-- Location list
vim.api.nvim_set_keymap("n", "<A-w>l", "<Cmd>lwindow<CR>", no_opts)
vim.api.nvim_set_keymap("n", "[l", "<Cmd>lprevious<CR>", no_opts)
vim.api.nvim_set_keymap("n", "]l", "<Cmd>lnext<CR>", no_opts)
vim.api.nvim_set_keymap("n", "[L", "<Cmd>lfirst<CR>", no_opts)
vim.api.nvim_set_keymap("n", "]L", "<Cmd>llast<CR>", no_opts)

-- Quickfix Window
vim.api.nvim_set_keymap("n", "<A-w>q", "<Cmd>cwindow<CR>", no_opts)
vim.api.nvim_set_keymap("n", "[q", "<Cmd>cprevious<CR>", no_opts)
vim.api.nvim_set_keymap("n", "]q", "<Cmd>cnext<CR>", no_opts)
vim.api.nvim_set_keymap("n", "[Q", "<Cmd>cfirst<CR>", no_opts)
vim.api.nvim_set_keymap("n", "]Q", "<Cmd>clast<CR>", no_opts)

-- switch between windows, preserving size
vim.api.nvim_set_keymap("n", "<A-h>", "<C-w><Left>", noremap)
vim.api.nvim_set_keymap("n", "<A-l>", "<C-w><Right>", noremap)
vim.api.nvim_set_keymap("n", "<A-k>", "<C-w><Up>", noremap)
vim.api.nvim_set_keymap("n", "<A-j>", "<C-w><Down>", noremap)

-- switch between windows, maximizing them
vim.api.nvim_set_keymap("n", "<Leader><A-h>", "<C-w><Left><Cmd>vertical resize<CR>", noremap)
vim.api.nvim_set_keymap("n", "<Leader><A-j>", "<C-w><Down><Cmd>horizontal resize<CR>", noremap)
vim.api.nvim_set_keymap("n", "<Leader><A-k>", "<C-w><Up><Cmd>horizontal resize<CR>", noremap)
vim.api.nvim_set_keymap("n", "<Leader><A-l>", "<C-w><Right><Cmd>vertical resize<CR>", noremap)

-- reset split size
vim.api.nvim_set_keymap("n", "<A-0>", "<C-w>=", noremap)

-- Tabs
vim.api.nvim_set_keymap("n", "[T", "<Cmd>tabfirst<CR>", no_opts)
vim.api.nvim_set_keymap("n", "[t", "<Cmd>tabprevious<CR>", no_opts)
vim.api.nvim_set_keymap("n", "]T", "<Cmd>tablast<CR>:", no_opts)
vim.api.nvim_set_keymap("n", "]t", "<Cmd>tabnext<CR>", no_opts)

-- Conflict markers

do
	local pattern = [[\v^[<|>]{7}\s.*$]]

	local modes = { "n", "x", "o" }

	vim.keymap.set(modes, "[X", "<Cmd>Jfirst " .. pattern .. "<CR>")
	vim.keymap.set(modes, "[x", "<Cmd>Jprevious " .. pattern .. "<CR>")
	vim.keymap.set(modes, "]x", "<Cmd>Jnext " .. pattern .. "<CR>")
	vim.keymap.set(modes, "]X", "<Cmd>Jlast " .. pattern .. "<CR>")

	vim.keymap.set(modes, "<A-w>x", "<Cmd>Jqflist " .. pattern .. "<CR>")
	vim.keymap.set(modes, "<A-w><A-x>", "<Cmd>Jloclist " .. pattern .. "<CR>")
end
