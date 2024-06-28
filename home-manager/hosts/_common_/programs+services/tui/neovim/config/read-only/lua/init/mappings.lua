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
vim.g.mapLeader = '\\'

local no_opts = {}
local noremap = {noremap = true}

--- @param option string the name of the option
--- @param setlocal? boolean the `nvim_set_option_value` options
--- @param map? (fun(value: unknown): unknown) the `nvim_set_option_value` options
--- @return fun(): nil
local function toggle(option, setlocal, map)
	return function()
		local old_value = vim.api.nvim_get_option_value(option, no_opts)
		local new_value
		if map then
			new_value = map(old_value)
		else
			new_value = not old_value
		end

		vim.api.nvim_set_option_value(option, new_value, setlocal and {scope = 'local'} or no_opts)
	end
end

--[[
   __  ____
  /  |/  (_)__ ____
 / /|_/ / (_-</ __/
/_/  /_/_/___/\__/
--]]

-- Open link under cursor
vim.api.nvim_set_keymap('', 'gX', 'gx', noremap)

-- Highlighting inspect
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>Inspect<CR>', no_opts)

-- Syntax tree inspect
vim.api.nvim_set_keymap('n', '<F11>', '', {callback = function()
	local winnr = vim.api.nvim_get_current_win()
	local cursor = vim.api.nvim_win_get_cursor(winnr)

	vim.api.nvim_command 'InspectTree'
	local inspect_winnr = vim.api.nvim_get_current_win()

	vim.api.nvim_set_current_win(winnr)
	vim.api.nvim_win_set_cursor(winnr, cursor)
	vim.api.nvim_set_current_win(inspect_winnr)
end})

-- Make `p` in visual mode not overwrite the unnamed register by default. `P` now does that.
vim.api.nvim_set_keymap('x', 'p', 'P', noremap)
vim.api.nvim_set_keymap('x', 'P', 'p', noremap)

-- Sort selected text
vim.api.nvim_set_keymap('x', '<Leader>s', ":sort iu<CR>", no_opts)

--[[
   ____              _
  / __/__  ___ _____(_)__  ___ _
 _\ \/ _ \/ _ `/ __/ / _ \/ _ `/
/___/ .__/\_,_/\__/_/_//_/\_, /
   /_/                   /___/
--]]

vim.api.nvim_set_keymap('n', '<Leader><C-v>', '', {callback = toggle 'paste'})

-- Reset kerning
vim.api.nvim_set_keymap('', '<Leader>rk', 'kJi<C-m><Esc>', noremap)

-- Copy to clipboard
vim.keymap.set({'x', 'n'}, '<Leader>y', '"+y')
vim.api.nvim_set_keymap('n', '<Leader>Y', '"+y$', noremap)

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<Leader>p', 'a<C-r>+<Esc>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>P', 'A<C-r>+<Esc>', noremap)

-- Move lines visually rather than logically
vim.api.nvim_set_keymap('', '<C-j>', 'gj', noremap)
vim.api.nvim_set_keymap('', '<C-k>', 'gk', noremap)

-- Toggle concealing
local toggle_conceal = toggle('conceallevel', true, function(v) return v < 2 and 2 or 0 end)
vim.api.nvim_set_keymap('n', '<Leader>c', '', { callback = toggle_conceal })

--[[
  ____       __  _
 / __ \___  / /_(_)__  ___  ___
/ /_/ / _ \/ __/ / _ \/ _ \(_-<
\____/ .__/\__/_/\___/_//_/___/
    /_/
--]]

-- Toggle linewrap
vim.api.nvim_set_keymap('n', '<Leader>l', '', {callback = toggle('wrap', true)})

-- Toggle Spellcheck
vim.api.nvim_set_keymap('n', '<Leader>s', '', {callback = toggle('spell', true)})

vim.api.nvim_set_keymap('n', '<Leader>m', '', {
	callback = toggle('mouse', false, function(v)
		return v == '' and 'nvi' or ''
	end),
})

--[[
       _           ___                         __  _
 _  __(_)_ _   ___/ (_)__ ____ ____  ___  ___ / /_(_)___
| |/ / /  ' \_/ _  / / _ `/ _ `/ _ \/ _ \(_-</ __/ / __/
|___/_/_/_/_(_)_,_/_/\_,_/\_, /_//_/\___/___/\__/_/\__/
                         /___/
--]]
vim.api.nvim_set_keymap('n', '[d', '', {callback = vim.diagnostic.goto_prev})
vim.api.nvim_set_keymap('n', ']d', '', {callback = vim.diagnostic.goto_next})
vim.api.nvim_set_keymap('n', 'gC', '', {callback = function() vim.diagnostic.reset(nil, 0) end})
vim.api.nvim_set_keymap('n', 'gK', '', {callback = vim.diagnostic.open_float})

--[[
       _         __
 _  __(_)_ _    / /__ ___
| |/ / /  ' \_ / (_-</ _ \
|___/_/_/_/_(_)_/___/ .__/
                   /_/
--]]
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local bufnr = event.buf
		local opts = { buffer = bufnr }

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gA', '', { callback = vim.lsp.buf.rename })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '', { callback = vim.lsp.buf.declaration })
		vim.keymap.set({ 'i', 'n' }, '<C-h>', vim.lsp.buf.signature_help, opts)

		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '', { callback = vim.lsp.buf.definition })
		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '', { callback = vim.lsp.buf.implementation })
		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '', { callback = vim.lsp.buf.references })
		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gw', '', { callback = vim.lsp.buf.document_symbol })
		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gW', '', { callback = vim.lsp.buf.workspace_symbol })
		-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '', { callback = vim.lsp.buf.type_definition })

		do
			local modes = { 'n', 'x' }
			-- vim.keymap.set(modes, 'gq', vim.lsp.buf.format, opts)
			vim.keymap.set(modes, 'gx', vim.lsp.buf.code_action, opts)
		end

		if vim.lsp.get_client_by_id(event.data.client_id).server_capabilities.inlayHintProvider then
			local conceallevel = vim.api.nvim_get_option_value('conceallevel', { scope = 'local' })

			local filter = { bufnr = bufnr }
			vim.lsp.inlay_hint.enable(conceallevel > 0, filter)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>c', '', { callback = function()
					local is_enabled = vim.lsp.inlay_hint.is_enabled(filter)
					vim.lsp.inlay_hint.enable(not is_enabled, filter)
					toggle_conceal()
			end })
		end
	end,
	group = 'config',
})

--[[
 _      ___         __
| | /| / (_)__  ___/ /__ _    _____
| |/ |/ / / _ \/ _  / _ \ |/|/ (_-<
|__/|__/_/_//_/\_,_/\___/__,__/___/
--]]

-- close window
vim.api.nvim_set_keymap('n', '<A-q>', '<Cmd>quit<CR>', no_opts)

-- Location list
vim.api.nvim_set_keymap('n', '<A-w>l', '<Cmd>lwindow<CR>', no_opts)
vim.api.nvim_set_keymap('n', '[l', '<Cmd>lprevious<CR>', no_opts)
vim.api.nvim_set_keymap('n', ']l', '<Cmd>lnext<CR>', no_opts)
vim.api.nvim_set_keymap('n', '[L', '<Cmd>lfirst<CR>', no_opts)
vim.api.nvim_set_keymap('n', ']L', '<Cmd>llast<CR>', no_opts)

-- Quickfix Window
vim.api.nvim_set_keymap('n', '<A-w>q', '<Cmd>cwindow<CR>', no_opts)
vim.api.nvim_set_keymap('n', '[q', '<Cmd>cprevious<CR>', no_opts)
vim.api.nvim_set_keymap('n', ']q', '<Cmd>cnext<CR>', no_opts)
vim.api.nvim_set_keymap('n', '[Q', '<Cmd>cfirst<CR>', no_opts)
vim.api.nvim_set_keymap('n', ']Q', '<Cmd>clast<CR>', no_opts)

-- switch between windows, preserving size
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w><Left>', noremap)
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w><Right>', noremap)
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w><Up>', noremap)
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w><Down>', noremap)

-- switch between windows, maximizing them
vim.api.nvim_set_keymap('n', '<Leader><A-h>', '<C-w><Left><Cmd>vertical resize<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><A-j>', '<C-w><Down><Cmd>horizontal resize<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><A-k>', '<C-w><Up><Cmd>horizontal resize<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><A-l>', '<C-w><Right><Cmd>vertical resize<CR>', noremap)

-- reset split size
vim.api.nvim_set_keymap('n', '<A-0>', '<C-w>=', noremap)

-- Tabs
vim.api.nvim_set_keymap('n', '[T', '<Cmd>tabfirst<CR>', no_opts)
vim.api.nvim_set_keymap('n', '[t', '<Cmd>tabprevious<CR>', no_opts)
vim.api.nvim_set_keymap('n', ']T', '<Cmd>tablast<CR>:', no_opts)
vim.api.nvim_set_keymap('n', ']t', '<Cmd>tabnext<CR>', no_opts)
